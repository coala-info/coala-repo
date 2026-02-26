# salty CWL Generation Report

## salty

### Tool Description
SALTy: A tool for rapid and accurate lineage assignment of bacterial genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/salty:1.0.6--pyhdfd78af_0
- **Homepage**: https://github.com/LanLab/salty
- **Package**: https://anaconda.org/channels/bioconda/packages/salty/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/salty/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LanLab/salty
- **Stars**: N/A
### Original Help Text
```text
usage: PROG [-h] [-t THREADS] [-f] [--report] [-v] [--check] [-i INPUT_FOLDER]
            [-o OUTPUT_FOLDER] [-c] [-s] [-l LINEAGES] [-k KMA_INDEX] [-m]

options:
  -h, --help            show this help message and exit

GENERAL:
  -t THREADS, --threads THREADS
                        Number of threads (speeds up parsing raw reads).
  -f, --force           Overwite existing output folder.
  --report              Only generate summary report from previous SALTy
                        outputs.
  -v, --version
  --check               check dependencies are installed

INPUT:
  -i INPUT_FOLDER, --input_folder INPUT_FOLDER
                        Folder of genomes (*.fasta or *.fna) and/or pair end
                        reads (each accession must have *_1.fastq.qz and
                        *_2.fastq.

OUTPUT:
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
                        Output Folder to save result.
  -c, --csv_format      Output file in csv format.
  -s, --summary         Concatenate all output assignments into single file.

DATABASE & PROGRAM Paths:
  -l LINEAGES, --lineages LINEAGES
                        Path to specific alleles for each lineage.
  -k KMA_INDEX, --kma_index KMA_INDEX
                        Path to indexed KMA database.
  -m, --mlstPrediction  Explained in ReadMe. Used as backup when lineage is
                        unable to be called through SaLTy screening. Marked
                        with *.
```

