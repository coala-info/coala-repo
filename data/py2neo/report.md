# py2neo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| py2neo_evaluate | Not completed | needs a running Neo4j server (connection refused without one); fixed baseCommand to py2neo evaluate and added network access |
| py2neo_run | Not completed | needs a running Neo4j server (connection refused without one); fixed baseCommand to py2neo run and added network access |

## py2neo_run

### Tool Description
Run a Cypher statement

### Metadata
- **Docker Image**: quay.io/biocontainers/py2neo:3.1.2--py34_0
- **Homepage**: https://github.com/MazzaWill/neo4j-python-pandas-py2neo-v3
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/py2neo/overview
- **Total Downloads**: 153.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MazzaWill/neo4j-python-pandas-py2neo-v3
- **Stars**: N/A
### Original Help Text
```text
usage: run [-h] [-H host] [-P port] statement

Run a Cypher statement

positional arguments:
  statement             Cypher statement

optional arguments:
  -h, --help            show this help message and exit
  -H host, --host host  database host
  -P port, --port port  database port (HTTP)

Report bugs to nigel@py2neo.org
```


## py2neo_evaluate

### Tool Description
Evaluate a Cypher statement

### Metadata
- **Docker Image**: quay.io/biocontainers/py2neo:3.1.2--py34_0
- **Homepage**: https://github.com/MazzaWill/neo4j-python-pandas-py2neo-v3
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: evaluate [-h] [-H host] [-P port] statement

Evaluate a Cypher statement

positional arguments:
  statement             Cypher statement

optional arguments:
  -h, --help            show this help message and exit
  -H host, --host host  database host
  -P port, --port port  database port (HTTP)

Report bugs to nigel@py2neo.org
```


## Metadata
- **Skill**: generated

