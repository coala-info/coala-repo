# cazy_webscraper CWL Generation Report

## cazy_webscraper

### Tool Description
Scrapes the CAZy database

### Metadata
- **Docker Image**: quay.io/biocontainers/cazy_webscraper:2.3.0.4--pyhdfd78af_0
- **Homepage**: https://hobnobmancer.github.io/cazy_webscraper/
- **Package**: https://anaconda.org/channels/bioconda/packages/cazy_webscraper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cazy_webscraper/overview
- **Total Downloads**: 20.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HobnobMancer/cazy_webscraper
- **Stars**: N/A
### Original Help Text
```text
Creating directory /root/.config/bioservices 
usage: cazy_webscraper.py [-h] [--cache_dir CACHE_DIR] [--cazy_data CAZY_DATA]
                          [--cazy_synonyms CAZY_SYNONYMS] [--classes CLASSES]
                          [-c config file] [-C] [-o DB_OUTPUT] [-d DATABASE]
                          [--delete_old_relationships] [-f]
                          [--families FAMILIES] [--genera GENERA]
                          [--kingdoms KINGDOMS] [-l log file name] [-n]
                          [--ncbi_batch_size NCBI_BATCH_SIZE]
                          [--nodelete_cache] [--nodelete_log] [-r RETRIES]
                          [--skip_ncbi_tax] [--sql_echo] [-s]
                          [--species SPECIES] [--strains STRAINS] [-t TIMEOUT]
                          [--validate] [-v] [-V]
                          [email]

Scrapes the CAZy database

positional arguments:
  email                 User email address. Requirement of Entrez, used to get
                        source organsism data. Email is not stored be
                        cazy_webscraper. (default: None)

optional arguments:
  -h, --help            show this help message and exit
  --cache_dir CACHE_DIR
                        Target path for cache dir to be used instead of
                        default path (default: None)
  --cazy_data CAZY_DATA
                        Path predownloaded CAZy txt file (default: None)
  --cazy_synonyms CAZY_SYNONYMS
                        Path to JSON file containing CAZy class synoymn names
                        (default: None)
  --classes CLASSES     Classes from which all families are to be scraped.
                        Separate classes by ',' (default: None)
  -c config file, --config config file
                        Path to configuration file. Default: None, scrapes
                        entire database (default: None)
  -C, --citation        Print cazy_webscraper citation message (default:
                        False)
  -o DB_OUTPUT, --db_output DB_OUTPUT
                        Target output path to build new SQL database (default:
                        None)
  -d DATABASE, --database DATABASE
                        Path to an existing local CAZy SQL database (default:
                        None)
  --delete_old_relationships
                        Delete old GenBank accession - CAZy family
                        relationships (annotations) that are in the local db
                        but are not in CAZy, e.g. when CAZy has moved a
                        protein from one fam to another, delete the old family
                        annotation. (default: False)
  -f, --force           Force file over writting (default: False)
  --families FAMILIES   Families to scrape. Separate families by commas
                        'GH1,GH2' (case sensitive) (default: None)
  --genera GENERA       Genera to restrict the scrape to (default: None)
  --kingdoms KINGDOMS   Tax Kingdoms to restrict the scrape to (default: None)
  -l log file name, --log log file name
                        Defines log file name and/or path (default: None)
  -n, --nodelete        When called, content in the existing out dir is NOT
                        deleted (default: False)
  --ncbi_batch_size NCBI_BATCH_SIZE
                        Number of genbank accessions in each NCBI Taxonomy db
                        batch query (default: 200)
  --nodelete_cache      When called, content in the existing cache dir is NOT
                        deleted (default: False)
  --nodelete_log        When called, content in the existing log dir is NOT
                        deleted (default: False)
  -r RETRIES, --retries RETRIES
                        Number of times to retry scraping a family or class
                        page if error encountered (default: 10)
  --skip_ncbi_tax       Skip retrieving the latest tax classification from the
                        NCBI Taxonomy db for proteins listed with multiple
                        taxs in CAZy. For these proteins the first taxonomy
                        listed in CAZy is added to the local CAZyme db
                        (default: False)
  --sql_echo            Set SQLite engine echo to True (SQLite will print its
                        log messages) (default: False)
  -s, --subfamilies     Enable retrieval of subfamilies from CAZy (default:
                        False)
  --species SPECIES     Species (written as Genus Species) to restrict the
                        scrape to (default: None)
  --strains STRAINS     Specific strains of organisms to restrict the scrape
                        to (written as Genus Species Strain) (default: None)
  -t TIMEOUT, --timeout TIMEOUT
                        Connection timeout limit (seconds) (default: 45)
  --validate            Retrieve CAZy fam population sizes from CAZy and use
                        to check the number of family members added to the
                        local database (default: False)
  -v, --verbose         Set logger level to 'INFO' (default: False)
  -V, --version         Print cazy_webscraper version number (default: False)
```

