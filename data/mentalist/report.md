# mentalist CWL Generation Report

## mentalist_call

### Tool Description
Calls alleles on a given MLST database. You can create a custom DB with 'create_db' or other MentaLiST functions that download schemes from pubmlst, cgmlst.org or Enterobase.

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Total Downloads**: 160.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/WGS-TB/MentaLiST
- **Stars**: N/A
### Original Help Text
```text
usage: mentalist call -o O --db DB [-t MUTATION_THRESHOLD] [--kt KT]
                      [--output_votes] [--output_special]
                      [-i SAMPLE_INPUT_FILE] [-1 [_1...]] [-2 [_2...]]
                      [--fasta] [-h]

optional arguments:
  -o O                  Output file with MLST call
  --db DB               Kmer database
  -t, --mutation_threshold MUTATION_THRESHOLD
                        Maximum number of mutations when looking for
                        novel alleles. (type: Int64, default: 6)
  --kt KT               Minimum # of times a kmer is seen to be
                        considered present in the sample (solid).
                        (type: Int64, default: 10)
  --output_votes        Outputs the results for the original voting
                        algorithm.
  --output_special      Outputs a FASTA file with the alleles from
                        'special cases' such as incomplete coverage,
                        novel, and multiple alleles.
  -i, --sample_input_file SAMPLE_INPUT_FILE
                        Input TXT file for multiple samples. First
                        column has the sample name, second the FASTQ
                        file. Repeat the sample name for samples with
                        more than one file (paired reads, f.i.)
  -1 [_1...]            FastQ input files, one per sample, forward
                        reads (or unpaired reads).
  -2 [_2...]            FastQ input files, one per sample, reverse
                        reads.
  --fasta               Input files are in FASTA format, instead of
                        the default FASTQs.
  -h, --help            show this help message and exit

MentaLiST MLST calling function. Calls alleles on a given MLST database.
You can create a custom DB with 'create_db' or other MentaLiST functions that download schemes from pubmlst, cgmlst.org or Enterobase.

Examples:
mentalist call -o my_sample.mlst --db my_scheme.db -1 sample_1.fastq.gz -2 sample_2.fastq.gz # one paired-end sample.
mentalist call -o all_samples.mlst --db my_scheme.db -1 *.fastq.gz -2 *.fastq.gz # multiple paired-end samples.
```


## mentalist_build_db

### Tool Description
Build a kmer database for MLST profiling.

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mentalist build_db --db DB -k K [--threads THREADS]
                        -f FASTA_FILES [FASTA_FILES...] [-p PROFILE]
                        [-h]

optional arguments:
  --db DB               Output file (kmer database)
  -k K                  Kmer size (type: Int8)
  --threads THREADS     Number of threads used in parallel. (type:
                        Int64, default: 2)
  -f, --fasta_files FASTA_FILES [FASTA_FILES...]
                        Fasta files with the MLST scheme
  -p, --profile PROFILE
                        Profile file for known genotypes.
  -h, --help            show this help message and exit
```


## mentalist_FASTA

### Tool Description
A command-line tool for analyzing microbial genomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

### Original Help Text
```text
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: imported binding for Dates overwritten in module Compat
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: imported binding for VERSION overwritten in module Main
unknown command: FASTA
usage: mentalist [-v]
                 {call|build_db|db_info|list_pubmlst|download_pubmlst|list_cgmlst|download_cgmlst|download_enterobase}
```


## mentalist_db_info

### Tool Description
MentaLiST kmer database information

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mentalist db_info --db DB [-h]

optional arguments:
  --db DB     MentaLiST kmer database
  -h, --help  show this help message and exit
```


## mentalist_k-mer

### Tool Description
A command-line tool for k-mer analysis and database operations.

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

### Original Help Text
```text
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: imported binding for Dates overwritten in module Compat
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: imported binding for VERSION overwritten in module Main
unknown command: k-mer
usage: mentalist [-v]
                 {call|build_db|db_info|list_pubmlst|download_pubmlst|list_cgmlst|download_cgmlst|download_enterobase}
```


## mentalist_list_pubmlst

### Tool Description
List available schemes from PubMLST

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mentalist list_pubmlst [-p PREFIX] [-h]

optional arguments:
  -p, --prefix PREFIX  Only list schemes where the species name starts
                       with this prefix.
  -h, --help           show this help message and exit
```


## mentalist_download_pubmlst

### Tool Description
Download a scheme from PubMLST and create a kmer database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mentalist download_pubmlst --db DB -k K [--threads THREADS]
                        -o OUTPUT -s SCHEME [-h]

optional arguments:
  --db DB              Output file (kmer database)
  -k K                 Kmer size (type: Int8)
  --threads THREADS    Number of threads used in parallel. (type:
                       Int64, default: 2)
  -o, --output OUTPUT  Output folder for the scheme Fasta files.
  -s, --scheme SCHEME  Species name or scheme ID.
  -h, --help           show this help message and exit
```


## mentalist_MLST

### Tool Description
A tool for MLST analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

### Original Help Text
```text
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: imported binding for Dates overwritten in module Compat
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: Error during initialization of module LinAlg:
ErrorException("could not load library "libopenblas.so"
libgfortran.so.3: cannot open shared object file: No such file or directory")
WARNING: imported binding for VERSION overwritten in module Main
unknown command: MLST
usage: mentalist [-v]
                 {call|build_db|db_info|list_pubmlst|download_pubmlst|list_cgmlst|download_cgmlst|download_enterobase}
```


## mentalist_list_cgmlst

### Tool Description
List available cgMLST schemes.

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mentalist list_cgmlst [-p PREFIX] [-h]

optional arguments:
  -p, --prefix PREFIX  Only list schemes where the species name starts
                       with this prefix.
  -h, --help           show this help message and exit
```


## mentalist_download_cgmlst

### Tool Description
Download a cgMLST scheme from the cgMLST finder database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mentalist download_cgmlst --db DB -k K [--threads THREADS]
                        -o OUTPUT -s SCHEME [-h]

optional arguments:
  --db DB              Output file (kmer database)
  -k K                 Kmer size (type: Int8)
  --threads THREADS    Number of threads used in parallel. (type:
                       Int64, default: 2)
  -o, --output OUTPUT  Output folder for the scheme Fasta files.
  -s, --scheme SCHEME  Species name or scheme ID.
  -h, --help           show this help message and exit
```


## mentalist_download_enterobase

### Tool Description
Download scheme data from Enterobase.

### Metadata
- **Docker Image**: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
- **Homepage**: https://github.com/WGS-TB/MentaLiST
- **Package**: https://anaconda.org/channels/bioconda/packages/mentalist/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mentalist download_enterobase --db DB -k K [--threads THREADS]
                        -o OUTPUT -s SCHEME -t TYPE [-h]

optional arguments:
  --db DB              Output file (kmer database)
  -k K                 Kmer size (type: Int8)
  --threads THREADS    Number of threads used in parallel. (type:
                       Int64, default: 2)
  -o, --output OUTPUT  Output folder for the scheme Fasta files.
  -s, --scheme SCHEME  Letter identifying which scheme: (S)almonella,
                       (Y)ersinia, or (E)scherichia/Shigella.
  -t, --type TYPE      Choose the type: 'cg' or 'wg' for cgMLST or
                       wgMLST scheme, respectively.
  -h, --help           show this help message and exit
```

