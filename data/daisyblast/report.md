# daisyblast CWL Generation Report

## daisyblast

### Tool Description
DaisyBlast: A tool to find and visualize synteny blocks from a single multi-FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/daisyblast:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/erinyoung/daisyblast
- **Package**: https://anaconda.org/channels/bioconda/packages/daisyblast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/daisyblast/overview
- **Total Downloads**: 41
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/erinyoung/daisyblast
- **Stars**: N/A
### Original Help Text
```text
usage: daisyblast [-h] -i INPUT [INPUT ...] [-o OUTPUT_DIR] [-e EVALUE]
                  [--min_pident MIN_PIDENT] [--min_length MIN_LENGTH]
                  [-n NUM_GROUPS] [-v]

DaisyBlast: A tool to find and visualize synteny blocks from a single multi-
FASTA file.

options:
  -h, --help            show this help message and exit
  -i, --input INPUT [INPUT ...]
                        One or more input FASTA files (e.g., contig1.fa
                        contig2.fa).
  -o, --output_dir OUTPUT_DIR
                        Directory to save output .bed and .png files.
                        (Default: daisyblast_results)
  -e, --evalue EVALUE   E-value cutoff for the self-BLAST search. (Default:
                        1e-10)
  --min_pident MIN_PIDENT
                        Minimum percent identity for a BLAST hit. (Default:
                        90.0)
  --min_length MIN_LENGTH
                        Minimum alignment length *after* splitting hits.
                        (Default: 500)
  -n, --num_groups NUM_GROUPS
                        Maximum number of groups in final bedfile (Default:
                        20)
  -v, --version         Show the version number and exit.
```

