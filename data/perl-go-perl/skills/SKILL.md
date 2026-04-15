---
name: perl-go-perl
description: This tool provides command-line utilities for processing, converting, and filtering Gene Ontology files and other structured biological ontologies. Use when user asks to convert ontology formats, filter ontologies by namespace, extract subgraphs, or validate OBO file syntax.
homepage: http://metacpan.org/pod/go-perl
metadata:
  docker_image: "quay.io/biocontainers/perl-go-perl:0.15--pl526_3"
---

# perl-go-perl

## Overview
The `perl-go-perl` suite provides a robust set of tools for bioinformaticians to interact with structured biological ontologies. It allows for the programmatic traversal of GO hierarchies, conversion between different ontology formats (such as OBO to GO-XML), and the extraction of specific subgraphs or term relationships. This skill focuses on the command-line utilities provided by the package to process ontology files efficiently.

## Core CLI Utilities
The package includes several scripts for common ontology tasks. Use these patterns for standard workflows:

### Format Conversion
Convert between OBO and various XML or text formats using `go2fmt.pl`:
- **OBO to GO-XML**: `go2fmt.pl -p obo_text -w xml file.obo > file.xml`
- **OBO to Summary**: `go2fmt.pl -p obo_text -w summary file.obo`
- **OBO to Pathlist**: `go2fmt.pl -p obo_text -w pathlist file.obo`

### Ontology Filtering and Extraction
Use `go-filter.pl` to create subsets of ontologies based on specific criteria:
- **Filter by Namespace**: `go-filter.pl -namespace molecular_function file.obo`
- **Extract Subgraph**: Use `-term <ID>` to extract a term and all its ancestors/descendants.

### Validation and Statistics
- **Check Syntax**: `go2fmt.pl -p obo_text -w null file.obo` (Returns errors if the OBO format is invalid).
- **Term Counts**: `go-stats.pl file.obo` provides a breakdown of terms, relationships, and leaf nodes.

## Expert Tips
- **Parser Selection**: Always specify the parser with `-p` (e.g., `obo_text`, `go_graph`, or `go_ont`) to ensure the script correctly interprets the input stream.
- **Memory Management**: For very large ontologies (like the full GO or Uberon), ensure your environment has sufficient RAM, as `go-perl` typically loads the entire graph into memory for processing.
- **Piping**: These tools are designed to work in Unix pipes. You can pipe the output of a curl command directly into `go2fmt.pl` by using `-` as the filename.

## Reference documentation
- [MetaCPAN go-perl Documentation](./references/metacpan_org_pod_go-perl.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-go-perl_overview.md)