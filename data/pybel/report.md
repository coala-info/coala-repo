# pybel CWL Generation Report

## pybel_compile

### Tool Description
Compile a BEL script to a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Total Downloads**: 26.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pybel/pybel
- **Stars**: N/A
### Original Help Text
```text
Usage: pybel compile [OPTIONS] PATH

  Compile a BEL script to a graph.

Options:
  --allow-naked-names             Enable lenient parsing for naked names
  --allow-nested                  Enable lenient parsing for nested statements
  --disallow-unqualified-translocations
                                  Disallow unqualified translocations
  --no-identifier-validation      Turn off identifier validation
  --no-citation-clearing          Turn off citation clearing
  -r, --required-annotations TEXT
                                  Specify multiple required annotations
  --skip-tqdm
  -v, --verbose
  --help                          Show this message and exit.
```

## pybel_insert

### Tool Description
Insert molecules into a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel insert [OPTIONS] path
Try "pybel insert --help" for help.

Error: no such option: --h  Did you mean --help?
```

## pybel_manage

### Tool Description
Manage the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage [OPTIONS] COMMAND [ARGS]...

  Manage the database.

Options:
  --help  Show this message and exit.

Commands:
  drop        Drop the database.
  edges       Manage edges.
  examples    Load examples to the database.
  namespaces  Manage namespaces.
  networks    Manage networks.
  nodes       Manage nodes.
  summarize   Summarize the contents of the database.
```

## pybel_neo

### Tool Description
Upload to neo4j.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel neo [OPTIONS] path

  Upload to neo4j.

Options:
  --connection TEXT  Connection string for neo4j upload.
  --password TEXT
  --help             Show this message and exit.
```

## pybel_post

### Tool Description
Upload a graph to BEL Commons.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel post [OPTIONS] path

  Upload a graph to BEL Commons.

Options:
  --host TEXT  URL of BEL Commons. Defaults to https://bel-
               commons.scai.fraunhofer.de
  --help       Show this message and exit.
```

## pybel_serialize

### Tool Description
Serialize a graph to a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel serialize [OPTIONS] path
Try "pybel serialize --help" for help.

Error: no such option: --h  Did you mean --help?
```

## pybel_summarize

### Tool Description
Summarize a chemical file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel summarize [OPTIONS] path
Try "pybel summarize --help" for help.

Error: no such option: --h  Did you mean --help?
```

## Metadata
- **Skill**: generated
