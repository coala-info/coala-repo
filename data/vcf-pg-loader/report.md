# vcf-pg-loader CWL Generation Report

## vcf-pg-loader_load

### Tool Description
Load a VCF file into PostgreSQL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/Zacharyr41/vcf-pg-loader
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Total Downloads**: 165
- **Last updated**: 2025-12-26
- **GitHub**: https://github.com/Zacharyr41/vcf-pg-loader
- **Stars**: N/A
### Original Help Text
```text
Usage: vcf-pg-loader load [OPTIONS] VCF_PATH                                   
                                                                                
 Load a VCF file into PostgreSQL.                                               
                                                                                
 If --db is not specified, uses the managed database (auto-starts if needed).   
 Use --db auto to explicitly use managed database, or provide a PostgreSQL URL. 
 Can also specify connection via --host, --port, --database, --user options.    
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    vcf_path      PATH  Path to VCF file (.vcf, .vcf.gz) [required]         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --db            -d                       TEXT     PostgreSQL URL ('auto' for │
│                                                   managed DB, omit to        │
│                                                   auto-detect)               │
│ --host                                   TEXT     PostgreSQL host            │
│ --port                                   INTEGER  PostgreSQL port            │
│ --database                               TEXT     Database name              │
│ --user                                   TEXT     Database user              │
│ --schema                                 TEXT     Target schema              │
│                                                   [default: public]          │
│ --sample-id                              TEXT     Sample ID override         │
│ --batch         -b                       INTEGER  Records per batch          │
│                                                   [default: 50000]           │
│ --workers       -w                       INTEGER  Parallel workers           │
│                                                   [default: 8]               │
│ --normalize         --no-normalize                Normalize variants         │
│                                                   [default: normalize]       │
│ --drop-indexes      --keep-indexes                Drop indexes during load   │
│                                                   [default: drop-indexes]    │
│ --human-genome      --no-human-genome             Use human chromosome enum  │
│                                                   type                       │
│                                                   [default: human-genome]    │
│ --force         -f                                Force reload even if file  │
│                                                   was already loaded         │
│ --config        -c                       PATH     TOML configuration file    │
│ --report        -r                       PATH     Write JSON report to file  │
│ --log                                    PATH     Write log to file          │
│ --verbose       -v                                Enable verbose logging     │
│ --quiet         -q                                Suppress non-error output  │
│ --progress          --no-progress                 Show progress bar          │
│                                                   [default: progress]        │
│ --help                                            Show this message and      │
│                                                   exit.                      │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## vcf-pg-loader_validate

### Tool Description
Validate a completed load.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/Zacharyr41/vcf-pg-loader
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vcf-pg-loader validate [OPTIONS] LOAD_BATCH_ID                          
                                                                                
 Validate a completed load.                                                     
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    load_batch_id      TEXT  Load batch UUID to validate [required]         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --db    -d      TEXT  PostgreSQL connection URL                              │
│                       [default: postgresql://localhost/variants]             │
│ --help                Show this message and exit.                            │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## vcf-pg-loader_init-db

### Tool Description
Initialize database schema.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/Zacharyr41/vcf-pg-loader
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vcf-pg-loader init-db [OPTIONS]                                         
                                                                                
 Initialize database schema.                                                    
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --db            -d                       TEXT  PostgreSQL connection URL     │
│                                                [default:                     │
│                                                postgresql://localhost/varia… │
│ --human-genome      --no-human-genome          Use human chromosome enum     │
│                                                type                          │
│                                                [default: human-genome]       │
│ --help                                         Show this message and exit.   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## vcf-pg-loader_benchmark

### Tool Description
Run performance benchmarks on VCF parsing and loading.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/Zacharyr41/vcf-pg-loader
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vcf-pg-loader benchmark [OPTIONS]                                       
                                                                                
 Run performance benchmarks on VCF parsing and loading.                         
                                                                                
 Examples:                                                                      
                                                                                
 # Quick benchmark with built-in fixture                                        
 vcf-pg-loader benchmark                                                        
                                                                                
 # Generate and benchmark 100K synthetic variants                               
 vcf-pg-loader benchmark --synthetic 100000                                     
                                                                                
 # Benchmark a specific VCF file                                                
 vcf-pg-loader benchmark --vcf sample.vcf.gz                                    
                                                                                
 # Full benchmark including database loading                                    
 vcf-pg-loader benchmark --synthetic 50000 --db postgresql://localhost/variants 
                                                                                
 # GIAB-style benchmark with platform/callset metadata                          
 vcf-pg-loader benchmark --synthetic 100000 --giab --db                         
 postgresql://localhost/variants                                                
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --vcf           -f                       PATH     Path to VCF file           │
│ --synthetic     -s                       INTEGER  Generate synthetic VCF     │
│                                                   with N variants            │
│ --db            -d                       TEXT     PostgreSQL URL (omit for   │
│                                                   parsing-only benchmark)    │
│ --batch         -b                       INTEGER  Records per batch          │
│                                                   [default: 50000]           │
│ --normalize         --no-normalize                Normalize variants         │
│                                                   [default: normalize]       │
│ --human-genome      --no-human-genome             Use human chromosome enum  │
│                                                   type                       │
│                                                   [default: human-genome]    │
│ --realistic     -r                                Generate realistic VCF     │
│                                                   with annotations and       │
│                                                   complex variants           │
│ --giab          -g                                Generate GIAB-style VCF    │
│                                                   with platform/callset      │
│                                                   metadata                   │
│ --json                                            Output results as JSON     │
│ --quiet         -q                                Minimal output             │
│ --help                                            Show this message and      │
│                                                   exit.                      │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## vcf-pg-loader_load-annotation

### Tool Description
Load an annotation VCF file as a reference database.
The annotation source can then be used to annotate query VCFs via SQL JOINs.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/Zacharyr41/vcf-pg-loader
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vcf-pg-loader load-annotation [OPTIONS] VCF_PATH                        
                                                                                
 Load an annotation VCF file as a reference database.                           
                                                                                
 The annotation source can then be used to annotate query VCFs via SQL JOINs.   
                                                                                
 Example:                                                                       
     vcf-pg-loader load-annotation gnomad.vcf.gz --name gnomad_v3 --config      
 gnomad.json                                                                    
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    vcf_path      PATH  Path to annotation VCF file (.vcf, .vcf.gz)         │
│                          [required]                                          │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --name          -n                       TEXT  Name for this annotation      │
│                                                source                        │
│ --config        -c                       PATH  JSON field configuration file │
│ --db            -d                       TEXT  PostgreSQL URL                │
│ --version       -v                       TEXT  Version string for this       │
│                                                source                        │
│ --type          -t                       TEXT  Source type (population,      │
│                                                pathogenicity, etc.)          │
│ --human-genome      --no-human-genome          Use human chromosome enum     │
│                                                type                          │
│                                                [default: human-genome]       │
│ --quiet         -q                             Suppress non-error output     │
│ --help                                         Show this message and exit.   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## vcf-pg-loader_list-annotations

### Tool Description
List all loaded annotation sources.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/Zacharyr41/vcf-pg-loader
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vcf-pg-loader list-annotations [OPTIONS]                                
                                                                                
 List all loaded annotation sources.                                            
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --db     -d      TEXT  PostgreSQL URL                                        │
│ --json                 Output as JSON                                        │
│ --quiet  -q            Suppress non-error output                             │
│ --help                 Show this message and exit.                           │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## vcf-pg-loader_annotate

### Tool Description
Annotate loaded variants using reference databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/Zacharyr41/vcf-pg-loader
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vcf-pg-loader annotate [OPTIONS] BATCH_ID                               
                                                                                
 Annotate loaded variants using reference databases.                            
                                                                                
 Example:                                                                       
 vcf-pg-loader annotate <batch-id> --source gnomad_v3 --filter "gnomad_af <     
 0.01"                                                                          
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    batch_id      TEXT  Load batch ID of variants to annotate [required]    │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --source  -s      TEXT     Annotation source(s) to use                       │
│ --filter  -f      TEXT     Filter expression (echtvar-style)                 │
│ --output  -o      PATH     Output file path                                  │
│ --format          TEXT     Output format (tsv, json) [default: tsv]          │
│ --limit   -l      INTEGER  Limit number of results                           │
│ --db      -d      TEXT     PostgreSQL URL                                    │
│ --quiet   -q               Suppress non-error output                         │
│ --help                     Show this message and exit.                       │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## vcf-pg-loader_annotation-query

### Tool Description
Execute an ad-hoc SQL query against annotation tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/Zacharyr41/vcf-pg-loader
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vcf-pg-loader annotation-query [OPTIONS]                                
                                                                                
 Execute an ad-hoc SQL query against annotation tables.                         
                                                                                
 Example:                                                                       
 vcf-pg-loader annotation-query --sql "SELECT * FROM anno_gnomad LIMIT 10"      
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --sql             TEXT  SQL query to execute [required]                   │
│    --db      -d      TEXT  PostgreSQL URL                                    │
│    --format          TEXT  Output format (tsv, json) [default: tsv]          │
│    --quiet   -q            Suppress non-error output                         │
│    --help                  Show this message and exit.                       │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## vcf-pg-loader_doctor

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/Zacharyr41/vcf-pg-loader
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: vcf-pg-loader doctor [OPTIONS]                                          
                                                                                
 Check system dependencies and configuration.                                   
                                                                                
 Verifies that all required dependencies are installed and                      
 provides installation instructions for any that are missing.                   
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## vcf-pg-loader_db

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/Zacharyr41/vcf-pg-loader
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-pg-loader/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: vcf-pg-loader db [OPTIONS] COMMAND [ARGS]...                            
                                                                                
 Manage the local PostgreSQL database                                           
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ start    Start the managed PostgreSQL database.                              │
│ stop     Stop the managed PostgreSQL database.                               │
│ status   Show status of the managed database.                                │
│ url      Print the database connection URL.                                  │
│ shell    Open a psql shell to the managed database.                          │
│ reset    Stop and remove the database including all data.                    │
╰──────────────────────────────────────────────────────────────────────────────╯
```

