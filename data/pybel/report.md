# pybel CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pybel_compile | PASS | real PyBEL test BEL document: pickle written, 4 nodes and 6 edges; writable script staged and network access added; exits 1 when the script has warnings |
| pybel_insert | PASS | real PyBEL test BEL document (two annotation URLs replaced by LIST because that host's certificate fails); database shows 1 network, 6 edges, 4 nodes |
| pybel_machine | Failed | image problem: the indra Python package is not installed in the image (ModuleNotFoundError) |
| pybel_manage_drop | PASS | database emptied (0 networks, 0 nodes) |
| pybel_manage_edges_ls | PASS | prints the BEL of the first edges |
| pybel_manage_examples | Not completed | needs the BEL resource server arty.scai.fraunhofer.de (connection timed out) |
| pybel_manage_namespaces_drop | PASS | namespace count falls back to 3 |
| pybel_manage_namespaces_insert | PASS | namespace count rises from 3 to 4 after adding a belns URL |
| pybel_manage_namespaces_ls | PASS | lists the entries of cached namespace 1 |
| pybel_manage_networks_drop | PASS | network 1 removed (0 networks, 0 edges) |
| pybel_manage_networks_ls | PASS | lists the inserted network by name and version |
| pybel_manage_nodes_prune | Failed | tool bug: crashes with UnmappedInstanceError (session.delete is given a list) |
| pybel_manage_summarize | PASS | counts match the inserted network (1 network, 6 edges, 4 nodes) |
| pybel_neo | Failed | image problem: the py2neo Python package is not installed in the image (ModuleNotFoundError); a Neo4j server would also be needed |
| pybel_post | Not completed | uploads the graph to the public BEL Commons web service; not run |
| pybel_serialize | PASS | csv, sif, gsea, graphml and json written and correct (6 edges); --bel crashes with a TypeError on the document's Project header |
| pybel_summarize | PASS | summary shows 4 nodes, 6 edges, 2 citations for the compiled document |
| pybel_warnings | PASS | lists the missing citation and evidence warnings of the real misordered.bel test document |

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

## pybel_machine

### Tool Description
Get content from the INDRA machine and upload to BEL Commons.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel machine [OPTIONS] [AGENTS]...

  Get content from the INDRA machine and upload to BEL Commons.

Options:
  --local      Upload to local database.
  --host TEXT  URL of BEL Commons. Defaults to https://bel-
               commons.scai.fraunhofer.de
  --help       Show this message and exit.
```

## pybel_manage_drop

### Tool Description
Drop the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage drop [OPTIONS]

  Drop the database.

Options:
  --yes   Confirm the action without prompting.
  --help  Show this message and exit.
```

## pybel_manage_edges_ls

### Tool Description
List edges.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage edges ls [OPTIONS]

  List edges.

Options:
  --offset INTEGER
  --limit INTEGER
  --help            Show this message and exit.
```

## pybel_manage_examples

### Tool Description
Load examples to the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage examples [OPTIONS]

  Load examples to the database.

Options:
  --help  Show this message and exit.
```

## pybel_manage_namespaces_drop

### Tool Description
Drop a namespace by URL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage namespaces drop [OPTIONS] URL

  Drop a namespace by URL.

Options:
  --help  Show this message and exit.
```

## pybel_manage_namespaces_insert

### Tool Description
Add a namespace by URL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage namespaces insert [OPTIONS] URL

  Add a namespace by URL.

Options:
  --help  Show this message and exit.
```

## pybel_manage_namespaces_ls

### Tool Description
List cached namespaces.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage namespaces ls [OPTIONS]

  List cached namespaces.

Options:
  -u, --url TEXT              Specific resource URL to list
  -i, --namespace-id INTEGER  Specific resource URL to list
  --help                      Show this message and exit.
```

## pybel_manage_networks_drop

### Tool Description
Drop a network by its identifier or drop all networks.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage networks drop [OPTIONS]

  Drop a network by its identifier or drop all networks.

Options:
  -n, --network-id INTEGER  Identifier of network to drop
  -y, --yes                 Drop all networks without confirmation if no
                            identifier is given
  --help                    Show this message and exit.
```

## pybel_manage_networks_ls

### Tool Description
List network names, versions, and optionally, descriptions.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage networks ls [OPTIONS]

  List network names, versions, and optionally, descriptions.

Options:
  --help  Show this message and exit.
```

## pybel_manage_nodes_prune

### Tool Description
Prune nodes not belonging to any edges.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage nodes prune [OPTIONS]

  Prune nodes not belonging to any edges.

Options:
  --help  Show this message and exit.
```

## pybel_manage_summarize

### Tool Description
Summarize the contents of the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel manage summarize [OPTIONS]

  Summarize the contents of the database.

Options:
  --help  Show this message and exit.
```

## pybel_warnings

### Tool Description
List warnings from a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybel:0.13.2--py_0
- **Homepage**: https://pybel.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/pybel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pybel warnings [OPTIONS] path

  List warnings from a graph.

Options:
  --help  Show this message and exit.
```

## Metadata
- **Skill**: generated
