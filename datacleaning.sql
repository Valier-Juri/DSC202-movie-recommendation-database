-- ==============================================
-- TABLE CREATION: Core Data Tables
-- ==============================================

CREATE TABLE movies (
    movieId INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genres TEXT
);

CREATE TABLE ratings (
    userId INT NOT NULL,
    movieId INT NOT NULL,
    rating FLOAT NOT NULL,
    timestamp BIGINT NOT NULL,
    PRIMARY KEY (userId, movieId),
    FOREIGN KEY (movieId) REFERENCES movies(movieId)
);

CREATE TABLE tags (
    userId INT NOT NULL,
    movieId INT NOT NULL,
    tag VARCHAR(255),
    timestamp BIGINT NOT NULL,
    PRIMARY KEY (userId, movieId, tag),
    FOREIGN KEY (movieId) REFERENCES movies(movieId)
);

CREATE TABLE genome_tags (
    tagId INT PRIMARY KEY,
    tag VARCHAR(255) NOT NULL
);

CREATE TABLE genome_scores (
    movieId INT NOT NULL,
    tagId INT NOT NULL,
    relevance FLOAT NOT NULL,
    PRIMARY KEY (movieId, tagId),
    FOREIGN KEY (tagId) REFERENCES genome_tags(tagId),
    FOREIGN KEY (movieId) REFERENCES movies(movieId)
);

CREATE TABLE links (
    movieId INT PRIMARY KEY,
    imdbId INT,
    tmdbId INT,
    FOREIGN KEY (movieId) REFERENCES movies(movieId)
);

CREATE TABLE imdb (
    id VARCHAR(15) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type VARCHAR(50),
    genres TEXT,
    averageRating FLOAT,
    numVotes INT,
    releaseYear INT
);

-- ==============================================
-- TABLE CREATION: Additional Metadata Tables
-- ==============================================

CREATE TABLE title_crew (
    tconst VARCHAR(20) PRIMARY KEY,
    directors TEXT,
    writers TEXT
);

CREATE TABLE name_basics (
    nconst VARCHAR(20) PRIMARY KEY,
    primaryName VARCHAR(255) NOT NULL,
    birthYear TEXT,
    deathYear TEXT,
    primaryProfession TEXT,
    knownForTitles TEXT
);

-- ==============================================
-- CREATING A TABLE FOR MOVIE DIRECTORS
-- ==============================================

DELETE FROM title_crew WHERE tconst = 'tconst'; -- Ensuring no placeholder values

CREATE TABLE movie_directors AS
SELECT
    tc.tconst,
    STRING_AGG(nb.primaryName, ', ') AS director_names
FROM title_crew tc
LEFT JOIN name_basics nb
    ON nb.nconst = ANY(string_to_array(tc.directors, ','))
WHERE tc.directors IS NOT NULL
GROUP BY tc.tconst;

-- ==============================================
-- INDEX CREATION FOR PERFORMANCE OPTIMIZATION
-- ==============================================

CREATE INDEX idx_ratings_movieId ON ratings(movieId);
CREATE INDEX idx_ratings_userId ON ratings(userId);
CREATE INDEX idx_links_imdbId ON links(imdbId);
CREATE INDEX idx_links_movieId ON links(movieId);
CREATE INDEX idx_tags_movieId ON tags(movieId);
CREATE INDEX idx_tags_userId ON tags(userId);
CREATE INDEX idx_genome_scores_movieId ON genome_scores(movieId);
CREATE INDEX idx_imdb_id ON imdb(id);
CREATE INDEX idx_imdb_numVotes ON imdb(numVotes);
CREATE INDEX idx_movie_directors_tconst ON movie_directors(tconst);

-- ==============================================
-- FILTERING TOP MOVIES BASED ON USER RATINGS
-- ==============================================

WITH TopMovies AS (
    SELECT 
        l.movieId, 
        i.id AS imdb_id, 
        i.title, 
        i.genres, 
        i.averageRating, 
        i.numVotes, 
        i.releaseYear
    FROM imdb i
    JOIN links l ON i.id = CONCAT('tt', l.imdbId)
    WHERE i.numVotes IS NOT NULL
    ORDER BY i.numVotes DESC
    LIMIT 5000
),
UserFilter AS (
    SELECT r.userId
    FROM ratings r
    JOIN TopMovies tm ON r.movieId = tm.movieId
    GROUP BY r.userId
    HAVING COUNT(r.movieId) >= 10
),
FilteredData AS (
    SELECT DISTINCT ON (r.userId, r.movieId, r.timestamp)
        r.userId,
        tm.imdb_id, 
        tm.title,
        tm.genres,
        tm.releaseYear,
        tm.averageRating,
        r.rating,
        r.timestamp,
        t.tag,
        g.relevance
    FROM ratings r
    JOIN TopMovies tm ON r.movieId = tm.movieId
    JOIN UserFilter uf ON r.userId = uf.userId
    LEFT JOIN tags t ON r.movieId = t.movieId AND r.userId = t.userId
    LEFT JOIN genome_scores g ON r.movieId = g.movieId
    WHERE g.relevance >= 0.5  
    AND t.tag IS NOT NULL      
    ORDER BY r.userId, r.movieId, r.timestamp, g.relevance DESC  
)
SELECT
    f.userId,
    f.imdb_id,  
    f.title,
    f.genres,
    f.releaseYear,
    f.averageRating,
    f.rating,
    f.timestamp,
    f.tag,
    f.relevance,
    COALESCE(d.director_names, 'Unknown') AS director_names  
FROM FilteredData f
LEFT JOIN movie_directors d ON f.imdb_id = d.tconst;
