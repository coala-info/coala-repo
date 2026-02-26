---
name: sofa-data
description: This tool executes a Python-based ETL pipeline to scrape and ingest sports data from SofaScore into a relational database. Use when user asks to scrape sports data from SofaScore, update player and manager attributes, or refresh database records for specific European football leagues.
homepage: https://github.com/danielsaban/data-scraping-sofascore
---


# sofa-data

## Overview
The sofa-data skill provides a specialized workflow for executing a Python-based ETL pipeline that targets SofaScore. It automates the extraction of granular data—including player physical attributes, manager tactical preferences, and stadium metadata—and handles the ingestion of this data into a relational database. Use this skill when you need to initialize a sports database or refresh existing records for specific European leagues.

## Setup and Configuration
Before running the scraper, ensure the environment is prepared and credentials are set:

1.  **Install Dependencies**: Run `pip install -r requirements.txt`.
2.  **Database Credentials**: You must manually edit `config.py` to include the correct database username and password.
3.  **WebDriver**: Ensure the appropriate `chromedriver` is available in the project directory for Selenium-based parsing.

## CLI Usage Patterns
The tool uses a flag-based system to determine which leagues to process. You can combine flags to scrape multiple leagues in a single execution.

### Basic Commands
*   **Scrape Serie A**: `python main.py -s`
*   **Scrape Premier League**: `python main.py -p`
*   **Scrape La Liga**: `python main.py -l`
*   **Scrape Bundesliga**: `python main.py -b`

### Multi-League Execution
To update the database with data from multiple leagues simultaneously, combine the flags:
`python main.py -s -p -l -b`

## Data Schema Insights
The scraper populates the database with three primary categories of information:

*   **Players**: Name, Nationality, Date of Birth, Height, Preferred Foot, Position, and Shirt Number.
*   **Managers**: Name, Date of Birth, Nationality, Preferred Formation, Average Points per Game (PPG), and Win/Loss/Draw records.
*   **Teams/Stadiums**: Short/Alternative names, Foundation year, Stadium capacity, Location, Description, and Social Media URLs.

## Expert Tips
*   **Data Persistence**: The tool uses an "overwrite" logic. If data for a selected league already exists in the database, the current scrape will replace the old records. Ensure you have backups if historical snapshots are required.
*   **Selenium Dependencies**: Since the tool relies on Selenium for parsing updated website structures, ensure your Chrome browser version matches the `chromedriver` version provided in the repository.
*   **API Integration**: The tool automatically supplements scraped web data with extra team information from external APIs; ensure your network environment allows outbound API requests during execution.

## Reference documentation
- [SofaScore Scraper Overview](./references/github_com_danielsaban_data-scraping-sofascore_blob_master_README.md)