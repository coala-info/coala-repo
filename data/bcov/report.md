# bcov CWL Generation Report

## bcov

### Tool Description
Computes beta strand pairing and contact maps from Multiple Sequence Alignments (MSAs) or pre-computed contact matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcov:1.0--h67df5e2_11
- **Homepage**: http://biocomp.unibo.it/savojard/bcov/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bcov/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcov/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-10-14
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
* BCov v1.0
* Copyright (C) 2013 Castrense Savojardo
*  Bologna Biocomputing Group
*  University of Bologna, Italy
*  savojard@biocomp.unibo.it


*** Some required arguments are not specified.

Usage: bcov [options]

Options:

-a file:	Input MSA file in the PSICOV format. A contact score matrix 
        	is internally computed using the PSICOV method (Jones et al., 2012).
        	This option conflicts with the -m option. REQUIRED if -m is not set

-m file:	Read a pre-computed residue contact score matrix from file. This
        	option conflicts with the -c option. REQUIRED if -a is not set

-s file:	Read beta strand boundaries from file. REQUIRED.

-c file:	Write predicted beta contact map to file. REQUIRED.

-o file:	Write predicted beta strand pairing to file. REQUIRED.

-n nnn:		Minimum sequence separation for parallel strand pairing.
       		0 = no threshold. OPTIONAL, default: 6

-v nnn:		Verbose level, 0/1 (default: 0).
```

