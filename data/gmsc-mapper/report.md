# gmsc-mapper CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gmsc-mapper | PASS | Ran with a local diamond database built from the SARS-CoV-2 proteome (annotation steps disabled); 7 of 9 query proteins aligned. |
| gmsc-mapper_createdb | PASS | Built a diamond database from the SARS-CoV-2 proteome; the mapper used it. |
| gmsc-mapper_downloaddb | Not completed | Needs a download of many GB (about 11 GB FASTA plus index files). |

## gmsc-mapper_downloaddb

### Tool Description
Download the GMSCMapper database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gmsc-mapper:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/GMSC-mapper
- **Package**: https://anaconda.org/channels/bioconda/packages/gmsc-mapper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gmsc-mapper/overview
- **Total Downloads**: 613
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BigDataBiology/GMSC-mapper
- **Stars**: N/A
### Original Help Text
```text
usage: gmsc-mapper downloaddb [-h] [--dbdir DBDIR] [--all] [-f]

options:
  -h, --help     show this help message and exit
  --dbdir DBDIR  Path to the database files.
  --all          Download all database
  -f             Force download even if the files exist
```


## gmsc-mapper_createdb

### Tool Description
Create a database for GMSC.

### Metadata
- **Docker Image**: quay.io/biocontainers/gmsc-mapper:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/GMSC-mapper
- **Package**: https://anaconda.org/channels/bioconda/packages/gmsc-mapper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gmsc-mapper createdb [-h] -i TARGET_FAA [-o OUTPUT] -m MODE [--quiet]

options:
  -h, --help            show this help message and exit
  -i TARGET_FAA         Path to the GMSC FASTA file.
  -o OUTPUT, --output OUTPUT
                        Path to database output directory.
  -m MODE, --mode MODE  Alignment tool (Diamond / MMseqs2)
  --quiet               Disable alignment console output
```


## gmsc-mapper

### Tool Description
GMSC-mapper: map genes or contigs to the GMSC catalogue and annotate them.

### Metadata
- **Docker Image**: quay.io/biocontainers/gmsc-mapper:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/GMSC-mapper
- **Package**: https://anaconda.org/channels/bioconda/packages/gmsc-mapper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gmsc-mapper [-h] [-i GENOME_FASTA] [--nt-genes NT_INPUT]
                   [--aa-genes AA_INPUT] [-o OUTPUT] [--tool {diamond,mmseqs}]
                   [-s SENSITIVITY] [--id IDENTITY] [--cov COVERAGE]
                   [-e EVALUE] [-t THREADS] [--filter] [--no-habitat]
                   [--no-taxonomy] [--no-quality] [--no-domain] [--quiet]
                   [--dbdir DBDIR]
                   ...

GMSC-mapper

options:
  -h, --help            show this help message and exit
  -i GENOME_FASTA, --input GENOME_FASTA
                        Path to the input genome contig sequence FASTA file.
                        (default: None)
  --nt-genes NT_INPUT, --nt_genes NT_INPUT
                        Path to the input nucleotide gene sequence FASTA file.
                        (default: None)
  --aa-genes AA_INPUT, --aa_genes AA_INPUT
                        Path to the input amino acid sequence FASTA file.
                        (default: None)
  -o OUTPUT, --output OUTPUT
                        Output directory (will be created if non-existent)
                        (default: /output)
  --tool {diamond,mmseqs}, --tool {diamond,mmseqs}
                        Sequence alignment tool (Diamond / MMseqs). (default:
                        diamond)
  -s SENSITIVITY, --sensitivity SENSITIVITY
                        Sensitivity. (default: None)
  --id IDENTITY, --id IDENTITY
                        Minimum identity to report an alignment (range
                        0.0-1.0). (default: 0.0)
  --cov COVERAGE, --cov COVERAGE
                        Minimum coverage to report an alignment (range
                        0.0-1.0). (default: 0.9)
  -e EVALUE, --evalue EVALUE
                        Maximum e-value to report alignments. (default: 1e-05)
  -t THREADS, --threads THREADS
                        Number of CPU threads. (default: 1)
  --filter, --filter    Use this to filter <100 aa or <303 nt input sequences.
                        (default: False)
  --no-habitat, --no-habitat
                        Use this if no need to annotate habitat (default:
                        False)
  --no-taxonomy, --no-taxonomy
                        Use this if no need to annotate taxonomy (default:
                        False)
  --no-quality, --no-quality
                        Use this if no need to annotate quality (default:
                        False)
  --no-domain, --no-domain
                        Use this if no need to annotate quality (default:
                        False)
  --quiet, --quiet      Disable alignment console output (default: False)
  --dbdir DBDIR, --dbdir DBDIR
                        Path to the GMSC database directory. (default: /db)

GMSC-mapper subcommands:
  
    downloaddb          Download target database
    createdb            Create target database
```


## Metadata
- **Skill**: generated
