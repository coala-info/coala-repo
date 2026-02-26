# taxmyphage CWL Generation Report

## taxmyphage_install

### Tool Description
Install taxmyphage databases and dependencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxmyphage:0.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/amillard/tax_myPHAGE
- **Package**: https://anaconda.org/channels/bioconda/packages/taxmyphage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxmyphage/overview
- **Total Downloads**: 17.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/amillard/tax_myPHAGE
- **Stars**: N/A
### Original Help Text
```text
usage: taxmyphage install [-h] [-v] [-V] [-db FOLDER_PATH]
                          [--makeblastdb MAKEBLASTDB]

options:
  -h, --help            show this help message and exit
  -v, --verbose         Show verbose output. (For debugging purposes)
  -V, --version         Show the version number and exit.

Databases options:
  -db FOLDER_PATH, --db_folder FOLDER_PATH
                        Path to the database directory where the databases are
                        stored. (Default is /usr/local/lib/python3.12/site-
                        packages/taxmyphage/database)

Install options:
  --makeblastdb MAKEBLASTDB
                        Path to the blastn executable (default: makeblastdb)
```


## taxmyphage_mash

### Tool Description
Performs MASH comparison for phage classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxmyphage:0.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/amillard/tax_myPHAGE
- **Package**: https://anaconda.org/channels/bioconda/packages/taxmyphage/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxmyphage mash [-h] -i [FASTA_FILE ...] [[FASTA_FILE ...] ...]
                       [-o OUTPUT] [-f] [-p PREFIX] [-t THREADS]
                       [--no-precomputed] [-d DIST] [--mash MASH]
                       [--blastdbcmd BLASTDBCMD] [-v] [-V] [-db FOLDER_PATH]

options:
  -h, --help            show this help message and exit
  -v, --verbose         Show verbose output. (For debugging purposes)
  -V, --version         Show the version number and exit.

General options:
  -i [FASTA_FILE ...] [[FASTA_FILE ...] ...], --input [FASTA_FILE ...] [[FASTA_FILE ...] ...]
                        Path to an input fasta file(s), or directory
                        containing fasta files. The fasta file(s) could
                        contain multiple phage genomes. They can be compressed
                        (gzip). If a directory is given the expected fasta
                        extentions are ['fasta', 'fna', 'fsa', 'fa'] but can
                        be gzipped. (Required)
  -o OUTPUT, --output OUTPUT
                        Path to the output directory. (Default is current
                        directory)
  -f, --force           Overwrites the genome output directory
  -p PREFIX, --prefix PREFIX
                        Will add the prefix to results and summary files that
                        will store results of MASH and comparision to the VMR
                        Data produced by ICTV combines both sets of this data
                        into a single csv file. Use this flag if you want to
                        run multiple times and keep the results files without
                        manual renaming of files. (Default no prefix)
  -t THREADS, --threads THREADS
                        Maximum number of threads that will be used by BLASTn.
                        (Default is 1)
  --no-precomputed      Don't use the precomputed blastn matrix

MASH options:
  -d DIST, --distance DIST
                        Will change the mash distance for the intial seraching
                        for close relatives. We suggesting keeping at 0.2 If
                        this results in the phage not being classified, then
                        increasing to 0.3 might result in an output that shows
                        the phage is a new genus. We have found increasing
                        above 0.2 does not place the query in any current
                        genus, only provides the output files to demonstrate
                        it falls outside of current genera. (Default is 0.2)
  --mash MASH           Path to the MASH executable (default: mash)
  --blastdbcmd BLASTDBCMD
                        Path to the blastn executable (default: blastdbcmd)

Databases options:
  -db FOLDER_PATH, --db_folder FOLDER_PATH
                        Path to the database directory where the databases are
                        stored. (Default is /usr/local/lib/python3.12/site-
                        packages/taxmyphage/database)
```


## taxmyphage_similarity

### Tool Description
Compares phage genomes and generates similarity reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxmyphage:0.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/amillard/tax_myPHAGE
- **Package**: https://anaconda.org/channels/bioconda/packages/taxmyphage/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxmyphage similarity [-h] -i [FASTA_FILE ...] [[FASTA_FILE ...] ...]
                             [-o OUTPUT] [-f] [-p PREFIX] [-t THREADS]
                             [--no-precomputed] [--reference REFERENCE]
                             [--blastn BLASTN] [--makeblastdb MAKEBLASTDB]
                             [--no-figures] [-v] [-V] [-db FOLDER_PATH]

options:
  -h, --help            show this help message and exit
  -v, --verbose         Show verbose output. (For debugging purposes)
  -V, --version         Show the version number and exit.

General options:
  -i [FASTA_FILE ...] [[FASTA_FILE ...] ...], --input [FASTA_FILE ...] [[FASTA_FILE ...] ...]
                        Path to an input fasta file(s), or directory
                        containing fasta files. The fasta file(s) could
                        contain multiple phage genomes. They can be compressed
                        (gzip). If a directory is given the expected fasta
                        extentions are ['fasta', 'fna', 'fsa', 'fa'] but can
                        be gzipped. (Required)
  -o OUTPUT, --output OUTPUT
                        Path to the output directory. (Default is current
                        directory)
  -f, --force           Overwrites the genome output directory
  -p PREFIX, --prefix PREFIX
                        Will add the prefix to results and summary files that
                        will store results of MASH and comparision to the VMR
                        Data produced by ICTV combines both sets of this data
                        into a single csv file. Use this flag if you want to
                        run multiple times and keep the results files without
                        manual renaming of files. (Default no prefix)
  -t THREADS, --threads THREADS
                        Maximum number of threads that will be used by BLASTn.
                        (Default is 1)
  --no-precomputed      Don't use the precomputed blastn matrix

Comparison options:
  --reference REFERENCE
                        Path to the reference database file. Input file will
                        be used as query against it. If not provided, input
                        will be compare against itself. If you use reference
                        no figure is generated. (Default is '')

Similarity options:
  --blastn BLASTN       Path to the blastn executable (default: blastn)
  --makeblastdb MAKEBLASTDB
                        Path to the blastn executable (default: makeblastdb)
  --no-figures          Use this option if you don't want to generate Figures.
                        This will speed up the time it takes to run the script
                        - but you get no Figures. (By default, Figures are
                        generated)

Databases options:
  -db FOLDER_PATH, --db_folder FOLDER_PATH
                        Path to the database directory where the databases are
                        stored. (Default is /usr/local/lib/python3.12/site-
                        packages/taxmyphage/database)
```


## taxmyphage_run

### Tool Description
Run taxmyphage analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/taxmyphage:0.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/amillard/tax_myPHAGE
- **Package**: https://anaconda.org/channels/bioconda/packages/taxmyphage/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxmyphage run [-h] -i [FASTA_FILE ...] [[FASTA_FILE ...] ...]
                      [-o OUTPUT] [-f] [-p PREFIX] [-t THREADS]
                      [--no-precomputed] [-d DIST] [--mash MASH]
                      [--blastdbcmd BLASTDBCMD] [--reference REFERENCE]
                      [--blastn BLASTN] [--makeblastdb MAKEBLASTDB]
                      [--no-figures] [-v] [-V] [-db FOLDER_PATH]

options:
  -h, --help            show this help message and exit
  -v, --verbose         Show verbose output. (For debugging purposes)
  -V, --version         Show the version number and exit.

General options:
  -i [FASTA_FILE ...] [[FASTA_FILE ...] ...], --input [FASTA_FILE ...] [[FASTA_FILE ...] ...]
                        Path to an input fasta file(s), or directory
                        containing fasta files. The fasta file(s) could
                        contain multiple phage genomes. They can be compressed
                        (gzip). If a directory is given the expected fasta
                        extentions are ['fasta', 'fna', 'fsa', 'fa'] but can
                        be gzipped. (Required)
  -o OUTPUT, --output OUTPUT
                        Path to the output directory. (Default is current
                        directory)
  -f, --force           Overwrites the genome output directory
  -p PREFIX, --prefix PREFIX
                        Will add the prefix to results and summary files that
                        will store results of MASH and comparision to the VMR
                        Data produced by ICTV combines both sets of this data
                        into a single csv file. Use this flag if you want to
                        run multiple times and keep the results files without
                        manual renaming of files. (Default no prefix)
  -t THREADS, --threads THREADS
                        Maximum number of threads that will be used by BLASTn.
                        (Default is 1)
  --no-precomputed      Don't use the precomputed blastn matrix

MASH options:
  -d DIST, --distance DIST
                        Will change the mash distance for the intial seraching
                        for close relatives. We suggesting keeping at 0.2 If
                        this results in the phage not being classified, then
                        increasing to 0.3 might result in an output that shows
                        the phage is a new genus. We have found increasing
                        above 0.2 does not place the query in any current
                        genus, only provides the output files to demonstrate
                        it falls outside of current genera. (Default is 0.2)
  --mash MASH           Path to the MASH executable (default: mash)
  --blastdbcmd BLASTDBCMD
                        Path to the blastn executable (default: blastdbcmd)

Comparison options:
  --reference REFERENCE
                        Path to the reference database file. Input file will
                        be used as query against it. If not provided, input
                        will be compare against itself. If you use reference
                        no figure is generated. (Default is '')

Similarity options:
  --blastn BLASTN       Path to the blastn executable (default: blastn)
  --makeblastdb MAKEBLASTDB
                        Path to the blastn executable (default: makeblastdb)
  --no-figures          Use this option if you don't want to generate Figures.
                        This will speed up the time it takes to run the script
                        - but you get no Figures. (By default, Figures are
                        generated)

Databases options:
  -db FOLDER_PATH, --db_folder FOLDER_PATH
                        Path to the database directory where the databases are
                        stored. (Default is /usr/local/lib/python3.12/site-
                        packages/taxmyphage/database)
```

