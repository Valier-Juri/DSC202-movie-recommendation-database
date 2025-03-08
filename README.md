# DSC250-movie-recommendation-database

## 📌 Overview
This is the group final project for DSC250.This project focuses on building robust databases—both relational (SQL) and graph-based (Neo4j)—for a movie recommendation system using the IMDb and Stanford MovieLens datasets. The emphasis is on database design, integration, and complex query formulation rather than algorithmic development in Python.

---

## 📁 Datasets
- **IMDb Dataset**: Includes movie metadata, actor/director details, genres, and textual descriptions.
- **Stanford MovieLens Dataset**: Includes user ratings, demographic data, and user-generated tags.

## 🗃️ Database Design

### 💾 SQL (Relational Database)
- **Tables:**
  - Users
  - Movies
  - Ratings
  - Actors
  - Directors
  - MovieActors
  - MovieDirectors
  - Tags

### 🌐 Neo4j (Graph Database)
- **Nodes:** Users, Movies, Actors, Directors, Genres, Tags
- **Relationships:**
  - User → Rated → Movie
  - Movie → ACTED_IN → Actor
  - Movie → Genre, Director, Tags

## 🔍 Data Integration & Preprocessing
- Matching and aligning movies from IMDb and MovieLens datasets
- Extracting textual features from IMDb data

## 🧩 Complex Queries & Analytical Operations
- User similarity based recommendations
- Graph centrality and community detection analyses
- Complex query examples provided through Neo4j Cypher

## 🎯 Project Goals & Outcomes
- Successfully integrated and validated relational and graph databases
- Executed complex, realistic recommendation queries
- Demonstrated analytical operations on graph data

## 🚀 Getting Started
1. Obtain and preprocess datasets
2. Set up SQL and Neo4j schemas
3. Populate databases
4. Execute and evaluate complex recommendation queries and analyses

