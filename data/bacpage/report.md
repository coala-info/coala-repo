# bacpage CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bacpage_assemble | Failed | image problem: the pipeline writes the bwa index into its own read-only package folder, so it runs only with --no-read-only and --no-match-user. |
| bacpage_identify_files | PASS |  |
| bacpage_phylogeny | Failed | image problem: run_gubbins.py is missing, so the default recombination detection fails; the tree builds only with --no-detect. |
| bacpage_profile | PASS |  |
| bacpage_setup | PASS |  |
| bacpage_utilities_extract_region | PASS |  |

## bacpage_assemble

### Tool Description
Assembles consensus sequence from raw sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
- **Homepage**: https://github.com/CholGen/bacpage
- **Package**: https://anaconda.org/channels/bioconda/packages/bacpage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bacpage/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-09-02
- **GitHub**: https://github.com/CholGen/bacpage
- **Stars**: N/A
### Original Help Text
```text
usage: bacpage assemble [-h] [--denovo] [--configfile CONFIGFILE]
                        [--samples SAMPLES] [--delim DELIM] [--index INDEX]
                        [--no-qa] [--threads THREADS] [--verbose]
                        [directory]

Assembles consensus sequence from raw sequencing reads.

positional arguments:
  directory             Path to valid project directory [current directory].

options:
  -h, --help            show this help message and exit
  --denovo              Perform de novo assembly rather than reference-based
                        assembly.
  --configfile CONFIGFILE
                        Path to assembly configuration file ['config.yaml'].
  --samples SAMPLES     Path to file detailing raw sequencing reads for all
                        samples ['sample_data.csv'].
  --delim DELIM         deliminator to extract sample name from file name [_]
  --index INDEX         index of sample name after splitting file name by
                        delim [0]
  --no-qa               Whether to skip quality assessment of assemblies
                        [False]
  --threads THREADS     Number of threads available for assembly [all].
  --verbose             Print lots of stuff to screen.
```

## bacpage_setup

### Tool Description
Set up project directory for analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
- **Homepage**: https://github.com/CholGen/bacpage
- **Package**: https://anaconda.org/channels/bioconda/packages/bacpage/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bacpage setup [-h] [--quiet] [--force] directory

Set up project directory for analysis.

positional arguments:
  directory   Location to create project directory

options:
  -h, --help  show this help message and exit
  --quiet     Do not display helpful messages during creation.
  --force     Generate directory wihtout checking if it is empty.
```

## bacpage_identify_files

### Tool Description
Generate a valid sample_data.csv from a directory of FASTQs.

### Metadata
- **Docker Image**: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
- **Homepage**: https://github.com/CholGen/bacpage
- **Package**: https://anaconda.org/channels/bioconda/packages/bacpage/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bacpage identify_files [-h] [--delim DELIM] [--index INDEX]
                              [--output OUTPUT]
                              directory

Generate a valid sample_data.csv from a directory of FASTQs.

positional arguments:
  directory        location of FASTQ files [current directory]

options:
  -h, --help       show this help message and exit
  --delim DELIM    deliminator to extract sample name from file name [_]
  --index INDEX    index of sample name after splitting file name by delim [0]
  --output OUTPUT  location to save sample data ['sample_data.csv']
```

## bacpage_phylogeny

### Tool Description
Reconstructs maximum likelihood phylogeny from consensus sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
- **Homepage**: https://github.com/CholGen/bacpage
- **Package**: https://anaconda.org/channels/bioconda/packages/bacpage/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bacpage phylogeny [-h] [--configfile CONFIGFILE]
                         [--minimum-completeness MINIMUM_COMPLETENESS]
                         [--terra] [--detect DETECT] [--no-detect]
                         [--mask MASK] [--threads THREADS] [--verbose]
                         directory

Reconstructs maximum likelihood phylogeny from consensus sequences.

positional arguments:
  directory             Path to valid project directory [current directory].

options:
  -h, --help            show this help message and exit
  --configfile CONFIGFILE
                        Path to assembly configuration file ['config.yaml'].
  --minimum-completeness MINIMUM_COMPLETENESS
                        minimum coverage required to be included in analysis
                        [0.9]
  --terra               Generate input for Terra and print instructions.
                        [False; runs pipeline locally]
  --detect DETECT       Bypass computationally intensive recombination
                        detection by supplying a GFF file previous generated
                        by gubbins.
  --no-detect           Skip performing recombinant region detection [False;
                        perform detection]
  --mask MASK           gff file used to mask to all sequences prior to tree
                        building. If not specified, sequences will not be
                        masked [False]
  --threads THREADS     Number of threads available for command [all].
  --verbose             Print lots of stuff to screen.
```

## bacpage_profile

### Tool Description
Reconstructs maximum likelihood phylogeny from consensus sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
- **Homepage**: https://github.com/CholGen/bacpage
- **Package**: https://anaconda.org/channels/bioconda/packages/bacpage/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bacpage profile [-h] [--configfile CONFIGFILE] [--database DATABASE]
                       [--threads THREADS] [--verbose]
                       [directory]

Reconstructs maximum likelihood phylogeny from consensus sequences.

positional arguments:
  directory             Path to valid project directory [current directory].

options:
  -h, --help            show this help message and exit
  --configfile CONFIGFILE
                        Path to assembly configuration file ['config.yaml'].
  --database DATABASE   Database to use for antimicrobial resistance
                        profiling.
  --threads THREADS     Number of threads available for command [all].
  --verbose             Print lots of stuff to screen.
```

## bacpage_utilities_extract_region

### Tool Description
Extract regions specified in a bed file from consensus sequences in a project directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
- **Homepage**: https://github.com/CholGen/bacpage
- **Package**: https://anaconda.org/channels/bioconda/packages/bacpage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bacpage/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-09-02
- **GitHub**: https://github.com/CholGen/bacpage
- **Stars**: N/A
### Original Help Text
```text
usage: bacpage utilities extract_region [-h] [--region REGION] directory

Extract regions specified in a bed file from consensus sequences in a project
directory.

positional arguments:
  directory        location of FASTQ files [current directory]

options:
  -h, --help       show this help message and exit
  --region REGION  BED file containing region(s) to extract.
```

## Metadata
- **Skill**: generated
