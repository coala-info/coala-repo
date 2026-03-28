# pacini_typing CWL Generation Report

## pacini_typing_makedatabase

### Tool Description
Builds a reference database for Pacini typing.

### Metadata
- **Docker Image**: quay.io/biocontainers/pacini_typing:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/RIVM-bioinformatics/Pacini-typing
- **Package**: https://anaconda.org/channels/bioconda/packages/pacini_typing/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pacini_typing/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-06-05
- **GitHub**: https://github.com/RIVM-bioinformatics/Pacini-typing
- **Stars**: N/A
### Original Help Text
```text
usage: Pacini-typing makedatabase [-h] -I File -db_type fastq/fasta -db_name
                                  name -db_path path

options:
  -h, --help            show this help message and exit
  -I File, --input_file File
                        Input file with genes that are being used for building
                        reference database
  -db_type fastq/fasta, --database_type fastq/fasta
                        Specify the database type that is being used
  -db_name name, --database_name name
                        Specify the name of the database
  -db_path path, --database_path path
                        Specify the path of the database
```


## pacini_typing_query

### Tool Description
Query the Pacini database with sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/pacini_typing:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/RIVM-bioinformatics/Pacini-typing
- **Package**: https://anaconda.org/channels/bioconda/packages/pacini_typing/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Pacini-typing query [-h] [-p file1 file2] [-s File] -db_name name
                           -db_path location -o Output

options:
  -h, --help            show this help message and exit
  -p file1 file2, --paired file1 file2
                        Paired-end reads to be used for query. Specify two
                        files separated by a space: -p file1 file2
  -s File, --single File
                        Single-end reads to be used for query. Specify one
                        file: -s file
  -db_name name, --database_name name
                        Specify the name of the database
  -db_path location, --database_path location
                        Specify the location of the database, ending with /
  -o Output, --output Output
                        Output file to store the results. Specify an output
                        file: -o output
```


## Metadata
- **Skill**: generated
