# kmerfinder CWL Generation Report

## kmerfinder_kmerfinder.py

### Tool Description
Run KmerFinder on FASTA(.gz) or FASTQ(.gz) files.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmerfinder:3.0.2--hdfd78af_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/kmerfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/kmerfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kmerfinder/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: kmerfinder.py [-h] [-i INFILE [INFILE ...]] [-batch BATCH_FILE]
                     [-o OUTPUT_FOLDER] [-db DB_PATH] [-db_batch DB_BATCH]
                     [-kma KMA_ARGUMENTS] [-tax TAX] [-x] [-kp KMA_PATH] [-q]

options:
  -h, --help            show this help message and exit
  -i INFILE [INFILE ...], --infile INFILE [INFILE ...]
                        FASTA(.gz) or FASTQ(.gz) file(s) to run KmerFinder on.
  -batch BATCH_FILE, --batch_file BATCH_FILE
                        OPTION NOT AVAILABLE:file with multipe files listed
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
                        folder to store the output
  -db DB_PATH, --db_path DB_PATH
                        path to database and database file
  -db_batch DB_BATCH, --db_batch DB_BATCH
                        OPTION NOT AVAILABLE:file with paths to multiple
                        databases
  -kma KMA_ARGUMENTS, --kma_arguments KMA_ARGUMENTS
                        OPTION NOT AVAILABLE:Extra arguments for KMA
  -tax TAX, --tax TAX   taxonomy file with additional data for each template
                        in all databases (family, taxid and organism)
  -x, --extended_output
                        Give extented output with taxonomy information
  -kp KMA_PATH, --kma_path KMA_PATH
                        Path to kma program
  -q, --quiet
```

