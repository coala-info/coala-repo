# openstructure CWL Generation Report

## openstructure_ost

### Tool Description
OpenStructure command-line interface

### Metadata
- **Docker Image**: quay.io/biocontainers/openstructure:2.11.1--py310h1f7f436_0
- **Homepage**: https://openstructure.org
- **Package**: https://anaconda.org/channels/bioconda/packages/openstructure/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/openstructure/overview
- **Total Downloads**: 57.5K
- **Last updated**: 2025-08-11
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: 
    ost [ost options] [script to execute] [script parameters]
    ost [action name] [action options]
    
The following actions are available:
  compare-ligand-structures
  compare-structures
  compare-structures-legacy

Each action should respond to "--help".

Options:
  -i, --interactive     start interpreter interactively (must be first
                        parameter, ignored otherwise)
  -h, --help            show this help message and exit
  -V, --version         show OST version and exit
  -v VLEVEL, --verbosity_level=VLEVEL
                        sets the verbosity level [default: 2]
```


## openstructure_molck

### Tool Description
the molecule checker

### Metadata
- **Docker Image**: quay.io/biocontainers/openstructure:2.11.1--py310h1f7f436_0
- **Homepage**: https://openstructure.org
- **Package**: https://anaconda.org/channels/bioconda/packages/openstructure/overview
- **Validation**: PASS

### Original Help Text
```text
unrecognised option '--help'
This is molck - the molecule checker
Usage: molck [options] file1.pdb [file2.pdb [...]]
Options
  --complib=path       Location of the compound library file. If not provided,
                       the following locations are searched in this order:
                       1. Working directory,
                       2. OpenStructure standard library location (if the
                          executable is part of a standard OpenStructure
                          installation)
  --rm=<a>,<b>         Remove atoms and residues matching some criteria:
                       - zeroocc - Remove atoms with zero occupancy
                       - hyd - Remove hydrogen atoms
                       - oxt - Remove terminal oxygens
                       - nonstd - Remove all residues not one of the
                                  20 standard amino acids
                       - unk - Remove unknown atoms not following
                               the nomenclature
                       Default: hyd
  --fix-ele            Clean up element column
  --stdout             Write cleaned file(s) to stdout
  --out=filename       Write cleaned file(s) to disk. % characters in the
                       filename are replaced with the basename of the input
                       file without extension. Default: %-molcked.pdb
  --color=auto|on|off  Whether output should be colored. Delault: auto
  --map-nonstd         Maps modified residues back to the parent amino acid,
                       for example: MSE -> MET, SEP -> SER.
```

