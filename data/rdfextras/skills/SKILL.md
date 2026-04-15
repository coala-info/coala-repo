---
name: rdfextras
description: rdfextras provides supplemental utilities and a SPARQL implementation for RDFLib to facilitate RDF data transformation and visualization. Use when user asks to convert CSV files to RDF, visualize RDF graphs as DOT files, parse or serialize RDF data using rdfpipe, or execute SPARQL queries in legacy RDFLib environments.
homepage: https://github.com/RDFLib/rdfextras
metadata:
  docker_image: "quay.io/biocontainers/rdfextras:0.4--py27_2"
---

# rdfextras

## Overview
The `rdfextras` package is a supplemental library for RDFLib, primarily used to provide a pure-Python SPARQL implementation for in-memory stores and a suite of command-line tools. While most of its functionality was merged into RDFLib core starting with version 4.0, this skill is essential for maintaining legacy systems or utilizing specific standalone utilities like `csv2rdf` and `rdf2dot` that facilitate rapid data transformation and visualization.

## Command-Line Utilities

### rdfpipe
Use `rdfpipe` to parse RDF data from various sources and serialize it into different formats. It is particularly useful for validating RDF syntax or converting between formats (e.g., XML to Turtle).

*   **Basic Conversion**: `rdfpipe -o turtle input.rdf > output.ttl`
*   **Multiple Inputs**: `rdfpipe input1.ttl input2.nt > combined.xml`

### csv2rdf
This tool converts tabular CSV data into RDF triples. It is a high-utility tool for bootstrapping linked data from spreadsheets.

*   **Standard Usage**: `csv2rdf -o output.n3 input.csv`
*   **Defining Base URI**: Use the `-b` flag to specify the base namespace for the generated resources.

### rdf2dot and rdfs2dot
These utilities generate Graphviz DOT files from RDF graphs or RDFS schemas, allowing for visual inspection of ontologies and data relationships.

*   **Generate Visualization**: `rdf2dot input.ttl | dot -Tpng -o graph.png`
*   **Schema Visualization**: `rdfs2dot schema.rdf | dot -Tpdf -o ontology.pdf`

## SPARQL Implementation
When using RDFLib 3.x, `rdfextras` must be installed to execute SPARQL queries against in-memory graphs.

*   **Plugin Registration**: Ensure `rdfextras` is installed in the environment; it automatically registers itself as a SPARQL plugin for RDFLib.
*   **Querying**: Use the `.query()` method on an RDFLib Graph object.

## Best Practices
*   **Version Check**: Always verify the RDFLib version. If using RDFLib >= 4.0, prefer the built-in `rdflib.tools` and core SPARQL engine over `rdfextras`.
*   **Dependency Management**: Ensure `pyparsing` is installed, as it is a strict requirement for the SPARQL parser within `rdfextras`.
*   **Piping**: Leverage Unix pipes with `rdf2dot` to avoid creating intermediate `.dot` files when generating images.



## Subcommands

| Command | Description |
|---------|-------------|
| csv2rdf.py | Reads csv files from stdin or given files if -d is given, use this delimiter if -s is given, skips N lines at the start Creates a URI from the columns given to -i, or automatically by numbering if none is given Outputs RDFS labels from the columns given to -l if -c is given adds a type triple with the given classname if -C is given, the class is defined as rdfs:Class Outputs one RDF triple per column in each row. Output is in n3 format. Output is stdout, unless -o is specified |
| rdf2dot | Converts RDF graphs to the DOT graph description language. |
| rdfpipe | A commandline tool for parsing RDF in different formats and serializing the resulting graph to a chosen format. Reads file system paths, URLs or from stdin if '-' is given. The result is serialized to stdout. |
| rdfs2dot | Converts an RDFS graph to a DOT graph. |

## Reference documentation
- [github_com_RDFLib_rdfextras_blob_master_README.md](./references/github_com_RDFLib_rdfextras_blob_master_README.md)
- [anaconda_org_channels_bioconda_packages_rdfextras_overview.md](./references/anaconda_org_channels_bioconda_packages_rdfextras_overview.md)