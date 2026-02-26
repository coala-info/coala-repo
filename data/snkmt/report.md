# snkmt CWL Generation Report

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


## snkmt_db

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/cademirch/snkmt
- **Package**: https://anaconda.org/channels/bioconda/packages/snkmt/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: snkmt db [OPTIONS] COMMAND [ARGS]...                                    
                                                                                
 Manage snkmt databases.                                                        
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ info      Display database information and schema version.                   │
│ migrate   Run database migrations to upgrade schema to latest version.       │
│ stamp     Manually stamp database with a schema revision without running     │
│           migrations.                                                        │
│ config    Manage database configuration.                                     │
╰──────────────────────────────────────────────────────────────────────────────╯
```

