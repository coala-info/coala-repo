# psauron CWL Generation Report

## psauron

### Tool Description
PSAURON: A tool for scoring spliced CDS or protein sequences using deep learning to determine protein-coding potential.

### Metadata
- **Docker Image**: quay.io/biocontainers/psauron:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/salzberg-lab/PSAURON
- **Package**: https://anaconda.org/channels/bioconda/packages/psauron/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/psauron/overview
- **Total Downloads**: 923
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/salzberg-lab/PSAURON
- **Stars**: N/A
### Original Help Text
```text
PSAURON version 1.0.6
usage: psauron [-h] -i INPUT_FASTA [-o OUTPUT_PATH] [-m MINIMUM_LENGTH]
               [-e EXCLUDE] [--inframe INFRAME] [--outframe OUTFRAME] [-c]
               [-s] [-p] [-a] [-v]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FASTA, --input-fasta INPUT_FASTA
                        REQUIRED path to FASTA with spliced CDS sequence or
                        protein sequence. A spliced CDS fasta can be created
                        from a GTF/GFF and a reference FASTA by using gffread.
  -o OUTPUT_PATH, --output-path OUTPUT_PATH
                        OPTIONAL path to output results file,
                        default=./psauron_score.csv
  -m MINIMUM_LENGTH, --minimum-length MINIMUM_LENGTH
                        OPTIONAL exclude all proteins shorter than m amino
                        acids, default=5
  -e EXCLUDE, --exclude EXCLUDE
                        OPTIONAL exclude any CDS where FASTA description
                        contains given text (case invariant), e.g.
                        "hypothetical", default=None
  --inframe INFRAME     OPTIONAL probability threshold used to determine final
                        psauron score, in-frame, higher number decreases
                        sensitivity and increases specificity, default=0.5,
                        range=[0,1]
  --outframe OUTFRAME   OPTIONAL probability threshold used to determine final
                        psauron score, out-of-frame, higher number increases
                        sensitivity and decreases specificity, default=0.5,
                        range=[0,1]
  -c, --use-cpu         OPTIONAL set -c to force usage of CPU instead of GPU,
                        default=False
  -s, --single-frame    OPTIONAL set -s to score only the in-frame CDS, which
                        may lower accuracy of the model, default=False
  -p, --protein         OPTIONAL set -p if your FASTA contains amino acid
                        protein sequence, which may lower accuracy of the
                        model, default=False
  -a, --all-prob        OPTIONAL set -a to output per-amino-acid predicted
                        probabilities, NOTE: these may not behave as expected
                        due to receptive field size, default=False
  -v, --verbose         OPTIONAL set -v for verbose output with progress bars
                        etc., default=False

 -i INPUT_FASTA, REQUIRED path to FASTA with spliced CDS sequence. This fasta can be created from a GTF/GFF and a reference FASTA by using gffread. 

Example gffread commands to get CDS FASTA:
gffread -x CDS_FASTA.fa -g genome.fa input.gff
gffread -x CDS_FASTA.fa -g genome.fa input.gtf
```

