# macrel CWL Generation Report

## macrel_peptides

### Tool Description
macrel v1.6.0

### Metadata
- **Docker Image**: quay.io/biocontainers/macrel:1.6.0--pyh7e72e81_1
- **Homepage**: https://github.com/BigDataBiology/macrel
- **Package**: https://anaconda.org/channels/bioconda/packages/macrel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/macrel/overview
- **Total Downloads**: 46.9K
- **Last updated**: 2025-11-24
- **GitHub**: https://github.com/BigDataBiology/macrel
- **Stars**: N/A
### Original Help Text
```text
usage: macrel [-h] [-t THREADS] [-o OUTPUT] [--file-output OUTPUT_FILE]
              [--tag OUTTAG] [-f FASTA_FILE] [-1 READS1] [-2 READS2]
              [--mem MEM] [--cluster] [--force] [--keep-fasta-headers]
              [--tmpdir TMPDIR] [--keep-negatives] [--version] [--verbose]
              [--quiet] [--log-file LOGFILE] [--log-append]
              [--query-mode QUERY_MODE] [--local] [--re-download-database]
              [--no-download-database] [--cache-dir CACHE_DIR]
              command

macrel v1.6.0

positional arguments:
  command               Macrel command to execute (see documentation)

options:
  -h, --help            show this help message and exit
  -t, --threads THREADS
                        Number of threads to use
  -o, --output OUTPUT   path to the output directory
  --file-output OUTPUT_FILE
                        path to the output file
  --tag OUTTAG          Set output tag
  -f, --fasta FASTA_FILE
                        path to the input FASTA file. This is used in both the
                        peptides command (where the file is expected to
                        contain short amino-acid sequences) and in the contigs
                        command (where the file is expected to contain longer
                        nucleotide contigs)
  -1, --reads1 READS1
  -2, --reads2 READS2
  --mem MEM
  --cluster             Whether to pre-cluster the smORFs (at 100% identity)
                        to avoid repeats
  --force
  --keep-fasta-headers  Keep complete FASTA headers [get-smorfs command]
  --tmpdir TMPDIR       Temporary directory to use (default: $TMPDIR in the
                        environment or /tmp)
  --keep-negatives      Whether to keep non-AMPs in the output
  --version, -v         show program's version number and exit
  --verbose, -V         Print debug information
  --quiet, -q           Print only errors
  --log-file LOGFILE    Path to the output logfile
  --log-append          If set, then the log file is appended to (default:
                        overwrite existing file)
  --query-mode QUERY_MODE
                        Query mode to use in the AMPSphere query (options:
                        exact, mmseqs, hhm)
  --local               Use local AMPSphere database
  --re-download-database
                        Download the AMPSphere database even if it already was
                        downloaded before
  --no-download-database
                        Do not download the AMPSphere database
  --cache-dir CACHE_DIR
                        Directory to use for caching AMPSphere data

Examples:
    run Macrel on peptides:
    macrel peptides --fasta example_seqs/expep.faa.gz --output out_peptides

    run Macrel on contigs:
    macrel contigs --fasta example_seqs/excontigs.fna.gz --output out_contigs

    run Macrel on paired-end reads:
    macrel reads -1 example_seqs/R1.fq.gz -2 example_seqs/R2.fq.gz --output out_metag --outtag example_metag

    run Macrel to get abundance profiles:
    macrel abundance -1 example_seqs/R1.fq.gz --fasta example_seqs/ref.faa.gz --output out_abundance --outtag example_abundance

    Query the AMPSphere database
    macrel query-ampsphere --query-mode mmseqs --fasta peptides.faa

    For more information,please read the docs: https://macrel.readthedocs.io/en/latest/
```


## macrel_contigs

### Tool Description
macrel v1.6.0

### Metadata
- **Docker Image**: quay.io/biocontainers/macrel:1.6.0--pyh7e72e81_1
- **Homepage**: https://github.com/BigDataBiology/macrel
- **Package**: https://anaconda.org/channels/bioconda/packages/macrel/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macrel [-h] [-t THREADS] [-o OUTPUT] [--file-output OUTPUT_FILE]
              [--tag OUTTAG] [-f FASTA_FILE] [-1 READS1] [-2 READS2]
              [--mem MEM] [--cluster] [--force] [--keep-fasta-headers]
              [--tmpdir TMPDIR] [--keep-negatives] [--version] [--verbose]
              [--quiet] [--log-file LOGFILE] [--log-append]
              [--query-mode QUERY_MODE] [--local] [--re-download-database]
              [--no-download-database] [--cache-dir CACHE_DIR]
              command

macrel v1.6.0

positional arguments:
  command               Macrel command to execute (see documentation)

options:
  -h, --help            show this help message and exit
  -t, --threads THREADS
                        Number of threads to use
  -o, --output OUTPUT   path to the output directory
  --file-output OUTPUT_FILE
                        path to the output file
  --tag OUTTAG          Set output tag
  -f, --fasta FASTA_FILE
                        path to the input FASTA file. This is used in both the
                        peptides command (where the file is expected to
                        contain short amino-acid sequences) and in the contigs
                        command (where the file is expected to contain longer
                        nucleotide contigs)
  -1, --reads1 READS1
  -2, --reads2 READS2
  --mem MEM
  --cluster             Whether to pre-cluster the smORFs (at 100% identity)
                        to avoid repeats
  --force
  --keep-fasta-headers  Keep complete FASTA headers [get-smorfs command]
  --tmpdir TMPDIR       Temporary directory to use (default: $TMPDIR in the
                        environment or /tmp)
  --keep-negatives      Whether to keep non-AMPs in the output
  --version, -v         show program's version number and exit
  --verbose, -V         Print debug information
  --quiet, -q           Print only errors
  --log-file LOGFILE    Path to the output logfile
  --log-append          If set, then the log file is appended to (default:
                        overwrite existing file)
  --query-mode QUERY_MODE
                        Query mode to use in the AMPSphere query (options:
                        exact, mmseqs, hhm)
  --local               Use local AMPSphere database
  --re-download-database
                        Download the AMPSphere database even if it already was
                        downloaded before
  --no-download-database
                        Do not download the AMPSphere database
  --cache-dir CACHE_DIR
                        Directory to use for caching AMPSphere data

Examples:
    run Macrel on peptides:
    macrel peptides --fasta example_seqs/expep.faa.gz --output out_peptides

    run Macrel on contigs:
    macrel contigs --fasta example_seqs/excontigs.fna.gz --output out_contigs

    run Macrel on paired-end reads:
    macrel reads -1 example_seqs/R1.fq.gz -2 example_seqs/R2.fq.gz --output out_metag --outtag example_metag

    run Macrel to get abundance profiles:
    macrel abundance -1 example_seqs/R1.fq.gz --fasta example_seqs/ref.faa.gz --output out_abundance --outtag example_abundance

    Query the AMPSphere database
    macrel query-ampsphere --query-mode mmseqs --fasta peptides.faa

    For more information,please read the docs: https://macrel.readthedocs.io/en/latest/
```


## macrel_reads

### Tool Description
Macrel command to execute (see documentation)

### Metadata
- **Docker Image**: quay.io/biocontainers/macrel:1.6.0--pyh7e72e81_1
- **Homepage**: https://github.com/BigDataBiology/macrel
- **Package**: https://anaconda.org/channels/bioconda/packages/macrel/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macrel [-h] [-t THREADS] [-o OUTPUT] [--file-output OUTPUT_FILE]
              [--tag OUTTAG] [-f FASTA_FILE] [-1 READS1] [-2 READS2]
              [--mem MEM] [--cluster] [--force] [--keep-fasta-headers]
              [--tmpdir TMPDIR] [--keep-negatives] [--version] [--verbose]
              [--quiet] [--log-file LOGFILE] [--log-append]
              [--query-mode QUERY_MODE] [--local] [--re-download-database]
              [--no-download-database] [--cache-dir CACHE_DIR]
              command

macrel v1.6.0

positional arguments:
  command               Macrel command to execute (see documentation)

options:
  -h, --help            show this help message and exit
  -t, --threads THREADS
                        Number of threads to use
  -o, --output OUTPUT   path to the output directory
  --file-output OUTPUT_FILE
                        path to the output file
  --tag OUTTAG          Set output tag
  -f, --fasta FASTA_FILE
                        path to the input FASTA file. This is used in both the
                        peptides command (where the file is expected to
                        contain short amino-acid sequences) and in the contigs
                        command (where the file is expected to contain longer
                        nucleotide contigs)
  -1, --reads1 READS1
  -2, --reads2 READS2
  --mem MEM
  --cluster             Whether to pre-cluster the smORFs (at 100% identity)
                        to avoid repeats
  --force
  --keep-fasta-headers  Keep complete FASTA headers [get-smorfs command]
  --tmpdir TMPDIR       Temporary directory to use (default: $TMPDIR in the
                        environment or /tmp)
  --keep-negatives      Whether to keep non-AMPs in the output
  --version, -v         show program's version number and exit
  --verbose, -V         Print debug information
  --quiet, -q           Print only errors
  --log-file LOGFILE    Path to the output logfile
  --log-append          If set, then the log file is appended to (default:
                        overwrite existing file)
  --query-mode QUERY_MODE
                        Query mode to use in the AMPSphere query (options:
                        exact, mmseqs, hhm)
  --local               Use local AMPSphere database
  --re-download-database
                        Download the AMPSphere database even if it already was
                        downloaded before
  --no-download-database
                        Do not download the AMPSphere database
  --cache-dir CACHE_DIR
                        Directory to use for caching AMPSphere data

Examples:
    run Macrel on peptides:
    macrel peptides --fasta example_seqs/expep.faa.gz --output out_peptides

    run Macrel on contigs:
    macrel contigs --fasta example_seqs/excontigs.fna.gz --output out_contigs

    run Macrel on paired-end reads:
    macrel reads -1 example_seqs/R1.fq.gz -2 example_seqs/R2.fq.gz --output out_metag --outtag example_metag

    run Macrel to get abundance profiles:
    macrel abundance -1 example_seqs/R1.fq.gz --fasta example_seqs/ref.faa.gz --output out_abundance --outtag example_abundance

    Query the AMPSphere database
    macrel query-ampsphere --query-mode mmseqs --fasta peptides.faa

    For more information,please read the docs: https://macrel.readthedocs.io/en/latest/
```


## macrel_abundance

### Tool Description
Macrel v1.6.0

### Metadata
- **Docker Image**: quay.io/biocontainers/macrel:1.6.0--pyh7e72e81_1
- **Homepage**: https://github.com/BigDataBiology/macrel
- **Package**: https://anaconda.org/channels/bioconda/packages/macrel/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macrel [-h] [-t THREADS] [-o OUTPUT] [--file-output OUTPUT_FILE]
              [--tag OUTTAG] [-f FASTA_FILE] [-1 READS1] [-2 READS2]
              [--mem MEM] [--cluster] [--force] [--keep-fasta-headers]
              [--tmpdir TMPDIR] [--keep-negatives] [--version] [--verbose]
              [--quiet] [--log-file LOGFILE] [--log-append]
              [--query-mode QUERY_MODE] [--local] [--re-download-database]
              [--no-download-database] [--cache-dir CACHE_DIR]
              command

macrel v1.6.0

positional arguments:
  command               Macrel command to execute (see documentation)

options:
  -h, --help            show this help message and exit
  -t, --threads THREADS
                        Number of threads to use
  -o, --output OUTPUT   path to the output directory
  --file-output OUTPUT_FILE
                        path to the output file
  --tag OUTTAG          Set output tag
  -f, --fasta FASTA_FILE
                        path to the input FASTA file. This is used in both the
                        peptides command (where the file is expected to
                        contain short amino-acid sequences) and in the contigs
                        command (where the file is expected to contain longer
                        nucleotide contigs)
  -1, --reads1 READS1
  -2, --reads2 READS2
  --mem MEM
  --cluster             Whether to pre-cluster the smORFs (at 100% identity)
                        to avoid repeats
  --force
  --keep-fasta-headers  Keep complete FASTA headers [get-smorfs command]
  --tmpdir TMPDIR       Temporary directory to use (default: $TMPDIR in the
                        environment or /tmp)
  --keep-negatives      Whether to keep non-AMPs in the output
  --version, -v         show program's version number and exit
  --verbose, -V         Print debug information
  --quiet, -q           Print only errors
  --log-file LOGFILE    Path to the output logfile
  --log-append          If set, then the log file is appended to (default:
                        overwrite existing file)
  --query-mode QUERY_MODE
                        Query mode to use in the AMPSphere query (options:
                        exact, mmseqs, hhm)
  --local               Use local AMPSphere database
  --re-download-database
                        Download the AMPSphere database even if it already was
                        downloaded before
  --no-download-database
                        Do not download the AMPSphere database
  --cache-dir CACHE_DIR
                        Directory to use for caching AMPSphere data

Examples:
    run Macrel on peptides:
    macrel peptides --fasta example_seqs/expep.faa.gz --output out_peptides

    run Macrel on contigs:
    macrel contigs --fasta example_seqs/excontigs.fna.gz --output out_contigs

    run Macrel on paired-end reads:
    macrel reads -1 example_seqs/R1.fq.gz -2 example_seqs/R2.fq.gz --output out_metag --outtag example_metag

    run Macrel to get abundance profiles:
    macrel abundance -1 example_seqs/R1.fq.gz --fasta example_seqs/ref.faa.gz --output out_abundance --outtag example_abundance

    Query the AMPSphere database
    macrel query-ampsphere --query-mode mmseqs --fasta peptides.faa

    For more information,please read the docs: https://macrel.readthedocs.io/en/latest/
```


## macrel_query-ampsphere

### Tool Description
macrel v1.6.0

### Metadata
- **Docker Image**: quay.io/biocontainers/macrel:1.6.0--pyh7e72e81_1
- **Homepage**: https://github.com/BigDataBiology/macrel
- **Package**: https://anaconda.org/channels/bioconda/packages/macrel/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macrel [-h] [-t THREADS] [-o OUTPUT] [--file-output OUTPUT_FILE]
              [--tag OUTTAG] [-f FASTA_FILE] [-1 READS1] [-2 READS2]
              [--mem MEM] [--cluster] [--force] [--keep-fasta-headers]
              [--tmpdir TMPDIR] [--keep-negatives] [--version] [--verbose]
              [--quiet] [--log-file LOGFILE] [--log-append]
              [--query-mode QUERY_MODE] [--local] [--re-download-database]
              [--no-download-database] [--cache-dir CACHE_DIR]
              command

macrel v1.6.0

positional arguments:
  command               Macrel command to execute (see documentation)

options:
  -h, --help            show this help message and exit
  -t, --threads THREADS
                        Number of threads to use
  -o, --output OUTPUT   path to the output directory
  --file-output OUTPUT_FILE
                        path to the output file
  --tag OUTTAG          Set output tag
  -f, --fasta FASTA_FILE
                        path to the input FASTA file. This is used in both the
                        peptides command (where the file is expected to
                        contain short amino-acid sequences) and in the contigs
                        command (where the file is expected to contain longer
                        nucleotide contigs)
  -1, --reads1 READS1
  -2, --reads2 READS2
  --mem MEM
  --cluster             Whether to pre-cluster the smORFs (at 100% identity)
                        to avoid repeats
  --force
  --keep-fasta-headers  Keep complete FASTA headers [get-smorfs command]
  --tmpdir TMPDIR       Temporary directory to use (default: $TMPDIR in the
                        environment or /tmp)
  --keep-negatives      Whether to keep non-AMPs in the output
  --version, -v         show program's version number and exit
  --verbose, -V         Print debug information
  --quiet, -q           Print only errors
  --log-file LOGFILE    Path to the output logfile
  --log-append          If set, then the log file is appended to (default:
                        overwrite existing file)
  --query-mode QUERY_MODE
                        Query mode to use in the AMPSphere query (options:
                        exact, mmseqs, hhm)
  --local               Use local AMPSphere database
  --re-download-database
                        Download the AMPSphere database even if it already was
                        downloaded before
  --no-download-database
                        Do not download the AMPSphere database
  --cache-dir CACHE_DIR
                        Directory to use for caching AMPSphere data

Examples:
    run Macrel on peptides:
    macrel peptides --fasta example_seqs/expep.faa.gz --output out_peptides

    run Macrel on contigs:
    macrel contigs --fasta example_seqs/excontigs.fna.gz --output out_contigs

    run Macrel on paired-end reads:
    macrel reads -1 example_seqs/R1.fq.gz -2 example_seqs/R2.fq.gz --output out_metag --outtag example_metag

    run Macrel to get abundance profiles:
    macrel abundance -1 example_seqs/R1.fq.gz --fasta example_seqs/ref.faa.gz --output out_abundance --outtag example_abundance

    Query the AMPSphere database
    macrel query-ampsphere --query-mode mmseqs --fasta peptides.faa

    For more information,please read the docs: https://macrel.readthedocs.io/en/latest/
```


## Metadata
- **Skill**: generated
