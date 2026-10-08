# eider CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| eider | PASS |  |

## eider

### Tool Description
Command line tools for DuckDB: run SQL queries through a JDBC connection.

### Metadata
- **Docker Image**: quay.io/biocontainers/eider:0.3--hdfd78af_0
- **Homepage**: https://github.com/heuermh/eider
- **Package**: https://anaconda.org/channels/bioconda/packages/eider/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
  eider [-hV] [--preserve-whitespace] [--skip-history] [--verbose]
        [-i=<queryPath>] [-q=<query>] [-u=<url>] [-p=<String=String>]...
        [COMMAND]

OPTIONS
  -u, --url=<url>                    JDBC connection URL, defaults to "jdbc:
                                       duckdb:".
  -q, --query=<query>                Inline SQL query, if any.
  -i, --query-path=<queryPath>       SQL query input path, default stdin.
  -p, --parameters=<String=String>   Query template parameters, in KEY=VALUE
                                       format. Specify multiple times if
                                       necessary.
      --preserve-whitespace          Preserve whitespace in SQL query.
      --skip-history                 Skip writing query to history file.
      --verbose                      Show additional logging messages.
  -h, --help                         Show this help message and exit.
  -V, --version                      Print version information and exit.

COMMANDS
  help                 Display help information about the specified command.
  generate-completion  Generate bash/zsh completion script for eider.
```

## Metadata
- **Skill**: generated
