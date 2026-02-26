# viromeqc CWL Generation Report

## viromeqc_viromeQC.py

### Tool Description
Checks a virome FASTQ file for enrichment efficiency

### Metadata
- **Docker Image**: quay.io/biocontainers/viromeqc:1.0.2--py310h7cba7a3_0
- **Homepage**: https://github.com/SegataLab/viromeqc
- **Package**: https://anaconda.org/channels/bioconda/packages/viromeqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viromeqc/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SegataLab/viromeqc
- **Stars**: N/A
### Original Help Text
```text
usage: viromeQC.py [-h] -i [INPUT ...] -o OUTPUT [--minlen MINLEN]
                   [--minqual MINQUAL] [--minlen_SSU MINLEN_SSU]
                   [--minlen_LSU MINLEN_LSU]
                   [--bowtie2_threads BOWTIE2_THREADS]
                   [--diamond_threads DIAMOND_THREADS]
                   [-w {human,environmental}] [--medians MEDIANS]
                   [--bowtie2_path BOWTIE2_PATH] [--diamond_path DIAMOND_PATH]
                   [--version] [--debug] [--install] [--zenodo]
                   [--sample_name SAMPLE_NAME] [--tempdir TEMPDIR]

Checks a virome FASTQ file for enrichment efficiency

options:
  -h, --help            show this help message and exit
  -i [INPUT ...], --input [INPUT ...]
                        Raw Reads in FASTQ format. Supports multiple inputs
                        (plain, gz o bz2) (default: None)
  -o OUTPUT, --output OUTPUT
                        output file (default: None)
  --minlen MINLEN       Minimum Read Length allowed (default: 75)
  --minqual MINQUAL     Minimum Read Average Phred quality (default: 20)
  --minlen_SSU MINLEN_SSU
                        Minimum alignment length when considering SSU rRNA
                        gene (default: 50)
  --minlen_LSU MINLEN_LSU
                        Minimum alignment length when considering LSU rRNA
                        gene (default: 50)
  --bowtie2_threads BOWTIE2_THREADS
                        Number of Threads to use with Bowtie2 (default: 4)
  --diamond_threads DIAMOND_THREADS
                        Number of Threads to use with Diamond (default: 4)
  -w {human,environmental}, --enrichment_preset {human,environmental}
                        Calculate the enrichment basing on human or
                        environmental metagenomes. Defualt: human-microbiome
                        (default: human)
  --medians MEDIANS     File containing reference medians to calculate the
                        enrichment. Default is medians.csv in the script
                        directory. You can specify a different file with this
                        parameter. (default: /usr/local/bin/medians.csv)
  --bowtie2_path BOWTIE2_PATH
                        Full path to the bowtie2 command to use, deafult
                        assumes that 'bowtie2 is present in the system path
                        (default: bowtie2)
  --diamond_path DIAMOND_PATH
                        Full path to the diamond command to use, deafult
                        assumes that 'diamond is present in the system path
                        (default: diamond)
  --version             Prints version informations (default: False)
  --debug               Prints error messages in case of debug (default:
                        False)
  --install             Downloads database files (default: False)
  --zenodo              Use Zenodo instead of Dropbox to download the DB
                        (default: False)
  --sample_name SAMPLE_NAME
                        Optional label for the sample to be included in the
                        output file (default: None)
  --tempdir TEMPDIR     Temporary Directory override (default is the system
                        temp directory) (default: None)
```

