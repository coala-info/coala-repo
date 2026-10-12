# pangbank-api CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pangbank-api_pangbank_db_add-collection-release | PASS | synthetic data: tool's own functional-test set (3 genomes, 2 pangenomes); new CWL written |
| pangbank-api_pangbank_db_delete-collection | PASS | synthetic data: tool's own functional-test set (3 genomes, 2 pangenomes); new CWL written |
| pangbank-api_pangbank_db_genome-metadata_add | PASS | synthetic data: tool's own functional-test set (3 genomes, 2 pangenomes); new CWL written |
| pangbank-api_pangbank_db_genome-metadata_delete | PASS | synthetic data: tool's own functional-test set (3 genomes, 2 pangenomes); new CWL written |
| pangbank-api_pangbank_db_genome-metadata_list | PASS | synthetic data: tool's own functional-test set (3 genomes, 2 pangenomes); new CWL written |
| pangbank-api_pangbank_db_list-collections | PASS | synthetic data: tool's own functional-test set (3 genomes, 2 pangenomes); new CWL written |

## pangbank-api_pangbank_db_add-collection-release

### Tool Description
Add a collection release (collection, taxonomy, genomes and pangenomes) to the pangbank database

### Metadata
- **Docker Image**: quay.io/biocontainers/pangbank-api:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/pangbank-api
- **Package**: https://anaconda.org/channels/bioconda/packages/pangbank-api/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: pangbank_db add-collection-release [OPTIONS] COLLECTION_RELEASE_JSON    
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    collection_release_json      PATH  Path to the collection release input │
│                                         json file.                           │
│                                         [required]                           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --pangbank-data-dir          PATH  Path to the pangbank data directory.      │
│                                    [env var: PANGBANK_DATA_DIR]              │
│                                    [default: .]                              │
│ --help               -h            Show this message and exit.               │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## pangbank-api_pangbank_db_list-collections

### Tool Description
List the collections and releases in the pangbank database

### Metadata
- **Docker Image**: quay.io/biocontainers/pangbank-api:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/pangbank-api
- **Package**: https://anaconda.org/channels/bioconda/packages/pangbank-api/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: pangbank_db list-collections [OPTIONS]                                  
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help  -h        Show this message and exit.                                │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## pangbank-api_pangbank_db_delete-collection

### Tool Description
Delete a collection, or one release of it, from the pangbank database

### Metadata
- **Docker Image**: quay.io/biocontainers/pangbank-api:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/pangbank-api
- **Package**: https://anaconda.org/channels/bioconda/packages/pangbank-api/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: pangbank_db delete-collection [OPTIONS] COLLECTION_NAME                 
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    collection_name      TEXT  Name of the collection to delete. [required] │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --release-version          TEXT  Specific release version to delete. If not  │
│                                  provided, the entire collection will be     │
│                                  deleted.                                    │
│ --help             -h            Show this message and exit.                 │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## pangbank-api_pangbank_db_genome-metadata_add

### Tool Description
Add a genome metadata source and its metadata table to the pangbank database

### Metadata
- **Docker Image**: quay.io/biocontainers/pangbank-api:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/pangbank-api
- **Package**: https://anaconda.org/channels/bioconda/packages/pangbank-api/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: pangbank_db genome-metadata add [OPTIONS] METADATA_SOURCE_FILE          
                                        METADATA_FILE                           
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    metadata_source_file      PATH  Path to a JSON file that describes the  │
│                                      metadata source contains file           │
│                                      information with genome metadata.       │
│                                      [required]                              │
│ *    metadata_file             PATH  Path to a TSV file that contains genome │
│                                      metadata. A column 'Genome' must be     │
│                                      present.                                │
│                                      [required]                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help  -h        Show this message and exit.                                │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## pangbank-api_pangbank_db_genome-metadata_delete

### Tool Description
Delete a genome metadata source from the pangbank database

### Metadata
- **Docker Image**: quay.io/biocontainers/pangbank-api:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/pangbank-api
- **Package**: https://anaconda.org/channels/bioconda/packages/pangbank-api/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: pangbank_db genome-metadata delete [OPTIONS] METADATA_SOURCE_NAME       
                                                                                
 Deletes a collection from the database if it exists.                           
                                                                                
 :param session: Database session used for querying and deleting the            
 collection. :param collection_name: Name of the collection to delete.          
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    metadata_source_name      TEXT  Name of the metadata source to delete   │
│                                      from the database.                      │
│                                      [required]                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --metadata-source-version          TEXT  Specific metadata source version to │
│                                          delete. If not provided, the entire │
│                                          source will be deleted.             │
│ --help                     -h            Show this message and exit.         │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## pangbank-api_pangbank_db_genome-metadata_list

### Tool Description
List all genome metadata sources in the pangbank database

### Metadata
- **Docker Image**: quay.io/biocontainers/pangbank-api:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/labgem/pangbank-api
- **Package**: https://anaconda.org/channels/bioconda/packages/pangbank-api/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: pangbank_db genome-metadata list [OPTIONS]                              
                                                                                
 List all genome metadata sources in the database.                              
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help  -h        Show this message and exit.                                │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## Metadata
- **Skill**: generated

