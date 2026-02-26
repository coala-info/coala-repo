# phigaro CWL Generation Report

## phigaro

### Tool Description
Phigaro is a scalable command-line tool for predictions phages and prophages
from nucleid acid sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/phigaro:2.4.0--pyhdfd78af_0
- **Homepage**: https://phigaro.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/phigaro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phigaro/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: phigaro [-h] [-V] -f FASTA_FILE [-c CONFIG] [-p]
               [-e EXTENSION [EXTENSION ...]] [-o OUTPUT] [--not-open]
               [-t THREADS] [--no-cleanup] [-S SUBSTITUTE_OUTPUT]
               [--save-fasta] [-d] [-m MODE]

Phigaro is a scalable command-line tool for predictions phages and prophages
from nucleid acid sequences

options:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  -f FASTA_FILE, --fasta-file FASTA_FILE
                        Assembly scaffolds/contigs or full genomes, required
  -c CONFIG, --config CONFIG
                        Path to the config file, not required. The deafult is
                        /root/.phigaro/config.yml
  -p, --print-vogs      Print phage vogs for each region
  -e EXTENSION [EXTENSION ...], --extension EXTENSION [EXTENSION ...]
                        Type of the output: html, tsv, gff, bed or stdout.
                        Default is html. You can specify several file formats
                        with a space as a separator. Example: -e tsv html
                        stdout.
  -o OUTPUT, --output OUTPUT
                        Output filename for html and txt outputs. Required by
                        default, but not required for stdout only output.
  --not-open            Do not open html file automatically, if html output
                        type is specified.
  -t THREADS, --threads THREADS
                        Num of threads (default is num of CPUs=20)
  --no-cleanup          Do not delete any temporary files that was generated
                        by Phigaro (HMMER & Prodigal outputs and some others).
  -S SUBSTITUTE_OUTPUT, --substitute-output SUBSTITUTE_OUTPUT
                        If you have precomputed prodigal and/or hmmer data you
                        can provide paths to the files in the following
                        format: program:address/to/the/file. In place of
                        program you should write hmmer or prodigal. If you
                        need to provide both files you should pass them
                        separetely as two parametres.
  --save-fasta          Save all phage fasta sequences in a fasta file.
  -d, --delete-shorts   Exclude sequences with length < 20000 automatically.
  -m MODE, --mode MODE  You can launch Phigaro at one of 3 modes: basic, abs,
                        without_gc. Default is basic. Read more about modes at
                        https://github.com/bobeobibo/phigaro/
```

