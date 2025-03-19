# DSC202-movie-recommendation-database

## Group Member
Caroline Zhang, Sijin Lyu, Tristan Cooper

## Overview
This is the group final project for DSC202.This project focuses on building robust databases—both relational (SQL) and graph-based (Neo4j)—for a movie recommendation system using the IMDb and Stanford MovieLens datasets. The emphasis is on database design, integration, and complex query formulation rather than algorithmic development in Python.

## **Instructions**

### **Step 1: Download Required Datasets**
Ensure you have downloaded the following datasets:

- **IMDb Comprehensive Dataset**  
  🔗 [Full IMDb Dataset](https://www.kaggle.com/datasets/octopusteam/full-imdb-dataset)  
  - Includes **movie metadata**, actor/director details, genres, ratings, and textual descriptions.

- **IMDb Non-Commercial Dataset**  
  🔗 [IMDb Dataset](https://developer.imdb.com/non-commercial-datasets/)  
  - We use:
    - `title.crew.tsv.gz` (movie-director mapping)
    - `name.basics.tsv.gz` (crew details)

- **MovieLens 25M Dataset**  
  🔗 [MovieLens 25M Dataset](https://grouplens.org/datasets/movielens/25m)  
  - Contains **25M+ ratings**, **1M+ tag applications**, and **62,423 movies** rated by **162,541 users**.
  - Provides user interaction data, including **ratings, tags, and tag relevance scores**.


### **Step 2: Prepare SQL Database**
1. **Run `datacleaning.sql`**:
   - Creates the **SQL schema**.
   - Prepares tables for storing **IMDb and MovieLens** datasets.

2. **Import datasets into SQL**:
   - The **`imdb` table** corresponds to the **Full IMDb Dataset**.
   - The **"Additional Metadata Tables"** correspond to the **IMDb Non-Commercial Dataset**.


### **Step 3: Follow Demonstration Notebook**
1. Open **`demonstration.ipynb`**.
2. Follow the step-by-step guide inside the notebook to:
   - Load and process data.
   - Integrate SQL and Neo4j.
   - Execute analytical queries.

## Database Design

### SQL (Relational Database)

### Neo4j (Graph Database)

- **Nodes:** Users, Movies, Directors, Genres, Tags, Keywords
- **Relationships:**
  - User → RATED → Movie
  - User → TAGGED → Movie
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


## References

chandan-u. 2016. “GitHub - Chandan-u/Graph-Based-Recommendation-System: Building a Recommendation System Using Graph Search Methodologies. We Will Be Comparing These Different Approaches and Closely Observe the Limitations of Each.” GitHub. 2016. https://github.com/chandan-u/graph-based-recommendation-system/tree/master.

- GroupLens. 2019. “MovieLens 25M Dataset.” GroupLens. December 10, 2019. https://grouplens.org/datasets/movielens/25m/.

- IMDb. 2023. “IMDb Non-Commercial Datasets.” Imdb.com. 2023. https://developer.imdb.com/non-commercial-datasets/.

- “Movie Recommender System.” 2025. Github.io. 2025. https://raveenak96.github.io/movies/.

- OctopusTeam. 2024. “Full IMDb Dataset (1M+).” Kaggle.com. 2024. https://www.kaggle.com/datasets/octopusteam/full-imdb-dataset.






