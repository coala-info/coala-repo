# ectyper CWL Generation Report

## ectyper

### Tool Description
Prediction of Escherichia coli serotype, pathotype and shiga toxin tying from raw reads or assembled genome sequences. The default settings are recommended.

### Metadata
- **Docker Image**: quay.io/biocontainers/ectyper:2.0.0--pyhdfd78af_4
- **Homepage**: https://github.com/phac-nml/ecoli_serotyping
- **Package**: https://anaconda.org/channels/bioconda/packages/ectyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ectyper/overview
- **Total Downloads**: 27.9K
- **Last updated**: 2025-05-12
- **GitHub**: https://github.com/phac-nml/ecoli_serotyping
- **Stars**: N/A
### Original Help Text
```text
usage: ectyper [-h] [-V] -i INPUT [INPUT ...] [--longreads]
               [--maxdirdepth MAXDIRDEPTH] [-c CORES]
               [-opid PERCENTIDENTITYOTYPE] [-hpid PERCENTIDENTITYHTYPE]
               [-opcov PERCENTCOVERAGEOTYPE] [-hpcov PERCENTCOVERAGEHTYPE]
               [--verify] [-o OUTPUT] [-r REFERENCE] [-s] [--debug]
               [--dbpath DBPATH] [--pathotype]
               [-pathpid PERCENTIDENTITYPATHOTYPE]
               [-pathpcov PERCENTCOVERAGEPATHOTYPE]

ectyper v2.0.0 antigen database v1.0. Prediction of Escherichia coli serotype,
pathotype and shiga toxin tying from raw reads or assembled genome sequences.
The default settings are recommended.

options:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  -i, --input INPUT [INPUT ...]
                        Location of E. coli genome file(s). Can be a single
                        file, a comma-separated list of files, or a directory
  --longreads           Enable for raw long reads FASTQ inputs (ONT, PacBio,
                        other sequencing platforms). [default False]
  --maxdirdepth MAXDIRDEPTH
                        Maximum number of directories to descend when
                        searching an input directory of files [default 0
                        levels]. Only works on path inputs not containing '*'
                        wildcard
  -c, --cores CORES     The number of cores to run ectyper with
  -opid, --percentIdentityOtype PERCENTIDENTITYOTYPE
                        Percent identity required for an O antigen allele
                        match [default 95]
  -hpid, --percentIdentityHtype PERCENTIDENTITYHTYPE
                        Percent identity required for an H antigen allele
                        match [default 95]
  -opcov, --percentCoverageOtype PERCENTCOVERAGEOTYPE
                        Minimum percent coverage required for an O antigen
                        allele match [default 90]
  -hpcov, --percentCoverageHtype PERCENTCOVERAGEHTYPE
                        Minimum percent coverage required for an H antigen
                        allele match [default 50]
  --verify              Enable E. coli species verification and additional QC
                        checks [default False]
  -o, --output OUTPUT   Directory location of output files
  -r, --reference REFERENCE
                        Location of pre-computed MASH sketch for species
                        identification. If provided, genomes identified as
                        non-E. coli will have their species identified using
                        MASH dist
  -s, --sequence        Prints the allele sequences if enabled as the final
                        columns of the output
  --debug               Print more detailed log including debug messages
  --dbpath DBPATH       Path to a custom database of O and H antigen alleles
                        in JSON format.
  --pathotype           Predict E.coli pathotype and Shiga toxin subtype(s) if
                        present
  -pathpid, --percentIdentityPathotype PERCENTIDENTITYPATHOTYPE
                        Minimum percent identity required for a pathotype
                        reference allele match [default: 90]
  -pathpcov, --percentCoveragePathotype PERCENTCOVERAGEPATHOTYPE
                        Minimum percent coverage required for a pathotype
                        reference allele match [default: 50]
```

