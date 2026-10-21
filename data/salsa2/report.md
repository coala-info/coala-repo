# salsa2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| salsa2_run_pipeline | PASS | Ran on Galaxy tools-iuc test data; scaffolds FASTA is identical to the expected file and the AGP matches. |

## salsa2_run_pipeline

### Tool Description
SALSA Iterative Pipeline: Hi-C scaffolding of a genome assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/salsa2:2.3--py27h16ec135_1
- **Homepage**: https://github.com/marbl/SALSA
- **Package**: https://anaconda.org/channels/bioconda/packages/salsa2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: run_pipeline.py [-h] -a ASSEMBLY -l LENGTH -b BED [-o OUTPUT]
                       [-c CUTOFF] [-g GFA] [-e ENZYME] [-i ITER] [-x DUP]
                       [-s EXP] [-m CLEAN] [-f FILTER] [-p PRNT]

SALSA Iterative Pipeline

optional arguments:
  -h, --help            show this help message and exit
  -a ASSEMBLY, --assembly ASSEMBLY
                        Path to initial assembly
  -l LENGTH, --length LENGTH
                        Length of contigs at start
  -b BED, --bed BED     Bed file of alignments sorted by read names
  -o OUTPUT, --output OUTPUT
                        Output directory to put results
  -c CUTOFF, --cutoff CUTOFF
                        Minimum contig length to scaffold, default=1000
  -g GFA, --gfa GFA     GFA file for assembly
  -e ENZYME, --enzyme ENZYME
                        Restriction Enzyme used for experiment
  -i ITER, --iter ITER  Number of iterations to run, default = 3
  -x DUP, --dup DUP     File containing duplicated contig information
  -s EXP, --exp EXP     Expected Genome size of the assembled genome
  -m CLEAN, --clean CLEAN
                        Set this option to "yes" if you want to find
                        misassemblies in input assembly
  -f FILTER, --filter FILTER
                        Filter bed file for contigs present in the assembly
  -p PRNT, --prnt PRNT  Set this option to "yes" if you want to output the
                        scaffolds sequence and agp file for each iteration
```

## Metadata
- **Skill**: generated
