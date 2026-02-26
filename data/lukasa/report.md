# lukasa CWL Generation Report

## lukasa_lukasa.py

### Tool Description
Wrapper to simplify running the lukasa protein evidence mapping workflow on the command line

### Metadata
- **Docker Image**: quay.io/biocontainers/lukasa:0.15.0--py310hdfd78af_0
- **Homepage**: https://github.com/pvanheus/lukasa
- **Package**: https://anaconda.org/channels/bioconda/packages/lukasa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lukasa/overview
- **Total Downloads**: 28.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pvanheus/lukasa
- **Stars**: N/A
### Original Help Text
```text
usage: lukasa.py [-h] [--output_filename OUTPUT_FILENAME]
                 [--workflow_dir WORKFLOW_DIR] [--max_intron MAX_INTRON]
                 [--min_intron MIN_INTRON] [--min_coverage MIN_COVERAGE]
                 [--eval EVAL] [--debug] [--leave_outputs]
                 [--species_table SPECIES_TABLE]
                 contigs_filename proteins_filename

Wrapper to simplify running the lukasa protein evidence mapping workflow on
the command line

positional arguments:
  contigs_filename      File with genomic contigs
  proteins_filename     File with proteins to map

options:
  -h, --help            show this help message and exit
  --output_filename OUTPUT_FILENAME
  --workflow_dir WORKFLOW_DIR
  --max_intron MAX_INTRON
                        Maximum intron length
  --min_intron MIN_INTRON
                        Minimum intron length
  --min_coverage MIN_COVERAGE
                        Minimum proportion of a gene that is exons
  --eval EVAL           Maximum E-value for MetaEuk
  --debug               Enable debug for cwltool
  --leave_outputs       Leave intermediate outputs
  --species_table SPECIES_TABLE
                        spaln species table to use
```

