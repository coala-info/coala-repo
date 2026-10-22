# snkmt CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| snkmt_console | Not completed | interactive terminal console, needs a terminal and a Snakemake monitoring database |
| snkmt_db_config_add | PASS | synthetic data: empty database created with the snkmt API |
| snkmt_db_config_discover | Not completed | asks a yes/no question that needs a terminal, so it fails without one |
| snkmt_db_config_list | PASS | synthetic data: empty database created with the snkmt API |
| snkmt_db_info | PASS | synthetic data: empty database created with the snkmt API |
| snkmt_db_migrate | PASS | synthetic data: empty database created with the snkmt API |
| snkmt_db_stamp | PASS | synthetic data: empty database created with the snkmt API |

## snkmt_console

### Tool Description
Launch the interactive console UI to monitor workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/cademirch/snkmt
- **Package**: https://anaconda.org/channels/bioconda/packages/snkmt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snkmt/overview
- **Total Downloads**: 168
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/cademirch/snkmt
- **Stars**: N/A
### Original Help Text
```text
Usage: snkmt console [OPTIONS]                                                 
                                                                                
 Launch the interactive console UI to monitor workflows.                        
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --db-path  -d      TEXT  Path to a snkmt database. Can be specified multiple │
│                          times to monitor multiple databases.                │
│ --help                   Show this message and exit.                         │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## snkmt_db_info

### Tool Description
Display database information and schema version.

### Metadata
- **Docker Image**: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/cademirch/snkmt
- **Package**: https://anaconda.org/channels/bioconda/packages/snkmt/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: snkmt db info [OPTIONS]                                                 
                                                                                
 Display database information and schema version.                               
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --db-path  -d      TEXT  Database path (default: user data dir).             │
│ --verbose  -v            Enable debug logging.                               │
│ --help                   Show this message and exit.                         │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## snkmt_db_migrate

### Tool Description
Run database migrations to upgrade schema to latest version.

### Metadata
- **Docker Image**: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/cademirch/snkmt
- **Package**: https://anaconda.org/channels/bioconda/packages/snkmt/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: snkmt db migrate [OPTIONS]                                              
                                                                                
 Run database migrations to upgrade schema to latest version.                   
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --db-path  -d      TEXT  Database path (default: user data dir).             │
│ --verbose  -v            Enable debug logging.                               │
│ --help                   Show this message and exit.                         │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## snkmt_db_stamp

### Tool Description
Manually stamp database with a schema revision without running migrations.

### Metadata
- **Docker Image**: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/cademirch/snkmt
- **Package**: https://anaconda.org/channels/bioconda/packages/snkmt/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: snkmt db stamp [OPTIONS] [REVISION]                                     
                                                                                
 Manually stamp database with a schema revision without running migrations.     
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│   revision      [REVISION]  Alembic revision to stamp (default: latest).     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --db-path  -d      TEXT  Database path (default: user data dir).             │
│ --verbose  -v            Enable debug logging.                               │
│ --help                   Show this message and exit.                         │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## snkmt_db_config_list

### Tool Description
List all configured databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/cademirch/snkmt
- **Package**: https://anaconda.org/channels/bioconda/packages/snkmt/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: snkmt db config list [OPTIONS]                                          
                                                                                
 List all configured databases.                                                 
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## snkmt_db_config_add

### Tool Description
Add a database to the configuration file.

### Metadata
- **Docker Image**: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/cademirch/snkmt
- **Package**: https://anaconda.org/channels/bioconda/packages/snkmt/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: snkmt db config add [OPTIONS] PATH                                      
                                                                                
 Add a database to the configuration file.                                      
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    path      TEXT  Path to the database file to add. [required]            │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --name  -n      TEXT  Display name for the database (default: filename       │
│                       stem).                                                 │
│ --help                Show this message and exit.                            │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## snkmt_db_config_discover

### Tool Description
Search for database files recursively and add them to configuration.

### Metadata
- **Docker Image**: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/cademirch/snkmt
- **Package**: https://anaconda.org/channels/bioconda/packages/snkmt/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: snkmt db config discover [OPTIONS] [DIRECTORY]                          
                                                                                
 Search for database files recursively and add them to configuration.           
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│   directory      [DIRECTORY]  Directory to search for .db files (default:    │
│                               current directory).                            │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```

