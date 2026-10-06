# kaiju CWL Generation Report

## Metadata
- **Skill**: generated

## kaiju_kaiju2krona

### Tool Description
Convert Kaiju output to Krona format

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Error: Please specify the name of the output file, using the -o option.

Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   /usr/local/bin/kaiju2krona -t nodes.dmp -n names.dmp -i kaiju.out -o kaiju2krona.out

Mandatory arguments:
   -i FILENAME   Name of input file
   -o FILENAME   Name of output file.
   -t FILENAME   Name of nodes.dmp file
   -n FILENAME   Name of names.dmp file

Optional arguments:
   -l            Print taxon path containing only ranks specified by a comma-separated list,
                 for example: superkingdom,phylum,class,order,family,genus,species
   -u            Include count for unclassified reads in output.
   -v            Enable verbose output.
```
