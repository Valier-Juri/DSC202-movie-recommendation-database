# DSC250-movie-recommendation-database

## Overview
This is the group final project for DSC250.This project focuses on building robust databases—both relational (SQL) and graph-based (Neo4j)—for a movie recommendation system using the IMDb and Stanford MovieLens datasets. The emphasis is on database design, integration, and complex query formulation rather than algorithmic development in Python.

## Datasets

- **IMDb Dataset** ([Full IMDb Dataset](https://www.kaggle.com/datasets/octopusteam/full-imdb-dataset)): Comprehensive movie metadata, actor/director details, genres, ratings, and textual descriptions.

- **MovieLens 25M Dataset** ([MovieLens 25M Dataset](https://grouplens.org/datasets/movielens/25m)): A benchmark dataset comprising 25 million ratings and 1 million tag applications across 62,423 movies by 162,541 users, providing extensive user interaction data including ratings, tags, and tag relevance scores.

## Database Design

### SQL (Relational Database)

- **Tables:**
  - Users
  - Movies
  - Ratings
  - Actors
  - Directors
  - MovieActors
  - MovieDirectors
  - Tags
  - TagGenome

### Neo4j (Graph Database)

- **Nodes:** Users, Movies, Actors, Directors, Genres, Tags, Keywords
- **Relationships:**
  - User → RATED → Movie
  - User → TAGGED → Movie
  - Movie → ACTED_IN → Actor
  - Movie → DIRECTED_BY → Director
  - Movie → OF_GENRE → Genre
  - Movie → HAS_TAG → Tags
  - Movie → RELATED_TO → Keywords (derived from tag genome relevance)
  - User → INTERESTED_IN → Keywords (based on tagging patterns)

## Data Integration & Preprocessing

- Matching and aligning movies from IMDb and MovieLens datasets based on title, year, and IMDb IDs.
- Extracting and normalizing textual features from IMDb descriptions and user-generated tags from MovieLens.
- Identifying and mapping relevant keywords to improve recommendation relevance and accuracy.

## Complex Queries & Analytical Operations

- Advanced, context-specific recommendations (e.g., "Movies suitable for a girls' night" or "Horror movies ideal for couples on Saturday night"), using keyword-based queries.
- Graph-based recommendations leveraging user similarities, tag relevance, and movie relationships.
- Centrality and community detection analyses to identify influential movies or user communities.
- Keyword extraction and analysis for precise recommendation targeting.

## Useful Resources

-([Requirement of this project](https://canvas.ucsd.edu/courses/62236/discussion_topics/891178))
-([Presentation of this project&Rubric](https://canvas.ucsd.edu/courses/62236/discussion_topics/898687))
- Report:
- Consider the report as a written elaboration of your presentation
- We will not prescribe a specific format for a graduate class, but it should have sections that roughly corresponds to your presentation.
- It is a technical report, written much like a scientific/technical paper. Describe your methodology, results, and limitations. Use code for illustration but do not cut and paste all your code.
- There should be a Conclusion Section that indicates the lessons learned, limitations and potential extensions of the project.




