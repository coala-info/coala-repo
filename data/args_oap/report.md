# args_oap CWL Generation Report

## args_oap_stage_one

### Tool Description
Stage one of the ARGs-OAP pipeline for antibiotic resistance genes (ARGs) analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/args_oap:3.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/xinehc/args_oap
- **Package**: https://anaconda.org/channels/bioconda/packages/args_oap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/args_oap/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/xinehc/args_oap
- **Stars**: N/A
### Original Help Text
```text
usage: args_oap stage_one [-h] -i DIR -o DIR [-t INT] [-f EXT] [--e1 FLOAT]
                          [--e2 FLOAT] [--id FLOAT] [--qcov FLOAT] [--skip]
                          [--keep] [--database FILE]

options:
  -h, --help            show this help message and exit

required arguments:
  -i DIR, --indir DIR   Input folder.
  -o DIR, --outdir DIR  Output folder.

optional arguments:
  -t INT, --thread INT  Number of threads. [8]
  -f EXT, --format EXT  File format in input folder (--indir), gzipped (*.gz)
                        optional. [fq]
  --e1 FLOAT            E-value cutoff for GreenGenes. [1e-10]
  --e2 FLOAT            E-value cutoff for Essential Single Copy Marker Genes.
                        [3]
  --id FLOAT            Identity cutoff (in percentage) for Essential Single
                        Copy Marker Genes. [45]
  --qcov FLOAT          Query cover cutoff (in percentage) for Essential
                        Single Copy Marker Genes. [0]
  --skip                Skip cell number and 16S copy number estimation.
  --keep                Keep all temporary files (*.tmp) in output folder
                        (--outdir).

database arguments:
  --database FILE       Customized database (indexed) other than SARG. [None]
```


## args_oap_stage_two

### Tool Description
Stage two of the ARGs-OAP pipeline for antibiotic resistance gene analysis, performing sequence alignment and classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/args_oap:3.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/xinehc/args_oap
- **Package**: https://anaconda.org/channels/bioconda/packages/args_oap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: args_oap stage_two [-h] -i DIR [-t INT] [-o DIR] [--e FLOAT]
                          [--id FLOAT] [--qcov FLOAT] [--length INT]
                          [--blastout FILE] [--database FILE]
                          [--structure1 FILE] [--structure2 FILE]
                          [--structure3 FILE]

options:
  -h, --help            show this help message and exit

required arguments:
  -i DIR, --indir DIR   Input folder. Should be the output folder of stage_one
                        (containing <metadata.txt> and <extracted.fa>).

optional arguments:
  -t INT, --thread INT  Number of threads. [8]
  -o DIR, --outdir DIR  Output folder, if not given then same as input folder
                        (--indir). [None]
  --e FLOAT             E-value cutoff for target sequences. [1e-7]
  --id FLOAT            Identity cutoff (in percentage) for target sequences.
                        [80]
  --qcov FLOAT          Query cover cutoff (in percentage) for target
                        sequences. [75]
  --length INT          Aligned length cutoff (in amino acid) for target
                        sequences. [25]
  --blastout FILE       BLAST output (-outfmt "6 qseqid sseqid pident length
                        qlen slen evalue bitscore"), if given then skip BLAST.
                        [None]

database arguments:
  --database FILE       Customized database (indexed) other than SARG. [None]
  --structure1 FILE     Customized structure file (weight 1, single-
                        component). [None]
  --structure2 FILE     Customized structure file (weight 1/2, two-component).
                        [None]
  --structure3 FILE     Customized structure file (weight 1/3, multi-
                        component). [None]
```


## args_oap_make_db

### Tool Description
Create a database from a FASTA file (nucleotide or protein).

### Metadata
- **Docker Image**: quay.io/biocontainers/args_oap:3.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/xinehc/args_oap
- **Package**: https://anaconda.org/channels/bioconda/packages/args_oap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: args_oap make_db [-h] -i FILE

options:
  -h, --help            show this help message and exit

required arguments:
  -i FILE, --infile FILE
                        Database FASTA file. Can be either nucleotide or
                        protein.
```


## Metadata
- **Skill**: generated
