# gffmunger CWL Generation Report

## gffmunger_move_polypeptide_annot

### Tool Description
Munges GFF files. Use one or more of the following commands:

### Metadata
- **Docker Image**: quay.io/biocontainers/gffmunger:0.1.3--py_0
- **Homepage**: https://github.com/sanger-pathogens/gffmunger
- **Package**: https://anaconda.org/channels/bioconda/packages/gffmunger/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gffmunger/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/gffmunger
- **Stars**: N/A
### Original Help Text
```text
usage: gffmunger [-h] [--verbose] [--quiet] [--no-validate] [--force]
                 [--fasta-file FASTA_FILE] [--input-file INPUT_FILE]
                 [--output-file OUTPUT_FILE] [--config CONFIG]
                 [--genometools GENOMETOOLS] [--version]
                 [command [command ...]]

Munges GFF files. Use one or more of the following commands:
  move_polypeptide_annot  transfer annotations from polypeptides to the
                          feature (e.g. mRNA) they derive from
  null                    do nothing

positional arguments:
  command               Command(s) defining how the GFF should be munged

optional arguments:
  -h, --help            show this help message and exit
  --verbose             Turn on debugging [False]
  --quiet, -q           Suppress messages & warnings [False]
  --no-validate, -n     Do not validate the input GFF3 [False]
  --force, -f           Force writing of output file, even if it already exists [False]
  --fasta-file FASTA_FILE, -a FASTA_FILE
                        Read FASTA from separate file instead of GFF3 input
  --input-file INPUT_FILE, -i INPUT_FILE
                        Read GFF3 from file instead of STDIN
  --output-file OUTPUT_FILE, -o OUTPUT_FILE
                        Write GFF3 to file instead of STDOUT
  --config CONFIG, -c CONFIG
                        Config file [/usr/local/config/gffmunger-config.yml]
  --genometools GENOMETOOLS, -g GENOMETOOLS
                        genometools path (override path in config)
  --version             Print version and exit
```


## gffmunger_null

### Tool Description
Munges GFF files. Use one or more of the following commands:

### Metadata
- **Docker Image**: quay.io/biocontainers/gffmunger:0.1.3--py_0
- **Homepage**: https://github.com/sanger-pathogens/gffmunger
- **Package**: https://anaconda.org/channels/bioconda/packages/gffmunger/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gffmunger [-h] [--verbose] [--quiet] [--no-validate] [--force]
                 [--fasta-file FASTA_FILE] [--input-file INPUT_FILE]
                 [--output-file OUTPUT_FILE] [--config CONFIG]
                 [--genometools GENOMETOOLS] [--version]
                 [command [command ...]]

Munges GFF files. Use one or more of the following commands:
  move_polypeptide_annot  transfer annotations from polypeptides to the
                          feature (e.g. mRNA) they derive from
  null                    do nothing

positional arguments:
  command               Command(s) defining how the GFF should be munged

optional arguments:
  -h, --help            show this help message and exit
  --verbose             Turn on debugging [False]
  --quiet, -q           Suppress messages & warnings [False]
  --no-validate, -n     Do not validate the input GFF3 [False]
  --force, -f           Force writing of output file, even if it already exists [False]
  --fasta-file FASTA_FILE, -a FASTA_FILE
                        Read FASTA from separate file instead of GFF3 input
  --input-file INPUT_FILE, -i INPUT_FILE
                        Read GFF3 from file instead of STDIN
  --output-file OUTPUT_FILE, -o OUTPUT_FILE
                        Write GFF3 to file instead of STDOUT
  --config CONFIG, -c CONFIG
                        Config file [/usr/local/config/gffmunger-config.yml]
  --genometools GENOMETOOLS, -g GENOMETOOLS
                        genometools path (override path in config)
  --version             Print version and exit
```

