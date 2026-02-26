# iseq CWL Generation Report

## iseq

### Tool Description
Download sequencing data and matadata for each Run from [GSA, SRA, ENA or DDBJ] databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/iseq:1.9.8--hdfd78af_0
- **Homepage**: https://github.com/BioOmics/iSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/iseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/iseq/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/BioOmics/iSeq
- **Stars**: N/A
### Original Help Text
```text
Description:
  Download sequencing data and matadata for each Run from [GSA, SRA, ENA or DDBJ] databases.

Usage:
  iseq -i accession [options]

Accepted accession formats:
    1.    Projects: PRJEB, PRJNA, PRJDB, PRJC, GSE
    2.     Studies: ERP, DRP, SRP, CRA
    3.  BioSamples: SAMD, SAME, SAMN, SAMC
    4.     Samples: ERS, DRS, SRS, GSM
    5. Experiments: ERX, DRX, SRX, CRX
    6.        Runs: ERR, DRR, SRR, CRR

Required option:
  -i, --input     [text|file]   Single accession or a file containing multiple accessions.
                                Note: Only one accession per line in the file.

Optional options:
  -m, --metadata                Skip the sequencing data downloads and only fetch the metadata for the accession.
  -g, --gzip                    Download FASTQ files in gzip format directly (*.fastq.gz).
                                Note: if *.fastq.gz files are not available, SRA files will be downloaded and converted to *.fastq.gz files.
  -q, --fastq                   Convert SRA files to FASTQ format.
  -t, --threads   int           The number of threads to use for converting SRA to FASTQ files or compressing FASTQ files (default: 8).
  -e, --merge     [ex|sa|st]    Merge multiple fastq files into one fastq file for each Experiment, Sample or Study.
                                ex: merge all fastq files of the same Experiment into one fastq file. Accession format: ERX, DRX, SRX, CRX.
                                sa: merge all fastq files of the same Sample into one fastq file. Accession format: ERS, DRS, SRS, SAMC, GSM.
                                st: merge all fastq files of the same Study into one fastq file. Accession format: ERP, DRP, SRP, CRA.
  -d, --database  [ena|sra]     Specify the database to download SRA sequencing data (default: ena).
                                Note: new SRA files may not be available in the ENA database, even if you specify "ena".
  -p, --parallel  int           Download sequencing data in parallel, the number of connections needs to be specified, such as -p 10.
                                Note: breakpoint continuation cannot be shared between different numbers of connections.
  -a, --aspera                  Use Aspera to download sequencing data, only support GSA/ENA database.
  -s, --speed     int           Download speed limit (MB/s) (default: 1000 MB/s).
  -k, --skip-md5                Skip the md5 check for the downloaded files.
  -r, --protocol  [ftp|https]   Specify the protocol only when downloading files from ENA (default: ftp).
  -Q, --quiet                   Suppress download progress bars.
  -o, --output    text          The output directory. If not exists, it will be created (default: current directory).
  -h, --help                    Show the help information.
  -v, --version                 Show the script version.

See example:
    https://github.com/BioOmics/iSeq/blob/main/docs/Examples.md

More information:
    https://github.com/BioOmics/iSeq
```

