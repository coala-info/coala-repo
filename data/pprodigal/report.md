# pprodigal CWL Generation Report

## pprodigal

### Tool Description
Parallel Prodigal gene prediction

### Metadata
- **Docker Image**: quay.io/biocontainers/pprodigal:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/sjaenick/pprodigal
- **Package**: https://anaconda.org/channels/bioconda/packages/pprodigal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pprodigal/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sjaenick/pprodigal
- **Stars**: N/A
### Original Help Text
```text
usage: pprodigal [-h] [-a PROTEINS] [-c] [-d NUCL] [-f FORMAT] [-g GENCODE]
                 [-i INPUT] [-m] [-n] [-o OUTPUT] [-p PROCEDURE]
                 [-s SCOREFILE] [-T TASKS] [-C CHUNKSIZE]

Parallel Prodigal gene prediction

options:
  -h, --help            show this help message and exit
  -a PROTEINS, --proteins PROTEINS
                        Write protein translations to the selected file.
  -c, --closed          Closed ends. Do not allow genes to run off edges.
  -d NUCL, --nucl NUCL  Write nucleotide sequences of genes to the selected
                        file.
  -f FORMAT, --format FORMAT
                        Select output format (gbk, gff, or sco). Default is
                        gbk.
  -g GENCODE, --gencode GENCODE
                        Specify a translation table to use (default 11).
  -i INPUT, --input INPUT
                        Specify FASTA/Genbank input file (default reads from
                        stdin).
  -m, --mask            Treat runs of N as masked sequence; don't build genes
                        across them.
  -n, --nosd            Bypass Shine-Dalgarno trainer and force a full motif
                        scan.
  -o OUTPUT, --output OUTPUT
                        Specify output file (default writes to stdout).
  -p PROCEDURE, --procedure PROCEDURE
                        Select procedure (single or meta). Default is single.
  -s SCOREFILE, --scorefile SCOREFILE
                        Write all potential genes (with scores) to the
                        selected file.
  -T TASKS, --tasks TASKS
                        number of prodigal processes to start in parallel
                        (default: 20)
  -C CHUNKSIZE, --chunksize CHUNKSIZE
                        number of input sequences to process within a chunk
                        (default: 2000)
```

