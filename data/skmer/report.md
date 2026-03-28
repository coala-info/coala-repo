# skmer CWL Generation Report

## skmer_reference

### Tool Description
Process a library of reference genome-skims or assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
- **Homepage**: https://github.com/shahab-sarmashghi/Skmer
- **Package**: https://anaconda.org/channels/bioconda/packages/skmer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/skmer/overview
- **Total Downloads**: 39.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shahab-sarmashghi/Skmer
- **Stars**: N/A
### Original Help Text
```text
usage: skmer reference [-h] [-l L] [-o O] [-k K] [-s S] [-S S] [-e E] [-t]
                       [-p P]
                       input_dir

Process a library of reference genome-skims or assemblies

positional arguments:
  input_dir   Directory of input genome-skims or assemblies (dir of
              .fastq/.fq/.fa/.fna/.fasta files)

options:
  -h, --help  show this help message and exit
  -l L        Directory of output (reference) library. Default:
              working_directory/library
  -o O        Output (distances) prefix. Default: ref-dist-mat
  -k K        K-mer length [1-31]. Default: 31
  -s S        Sketch size. Default: 100000
  -S S        Sketching random seed. Default: 42
  -e E        Base error rate. By default, the error rate is automatically
              estimated.
  -t          Apply Jukes-Cantor transformation to distances. Output 5.0 if
              not applicable
  -p P        Max number of processors to use [1-20]. Default for this
              machine: 20
```


## skmer_distance

### Tool Description
Compute the distance matrix for a processed library

### Metadata
- **Docker Image**: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
- **Homepage**: https://github.com/shahab-sarmashghi/Skmer
- **Package**: https://anaconda.org/channels/bioconda/packages/skmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: skmer distance [-h] [-o O] [-t] [-p P] library

Compute the distance matrix for a processed library

positional arguments:
  library     Directory of the input (processed) library

options:
  -h, --help  show this help message and exit
  -o O        Output (distances) prefix. Default: ref-dist-mat
  -t          Apply Jukes-Cantor transformation to distances. Output 5.0 if
              not applicable
  -p P        Max number of processors to use [1-20]. Default for this
              machine: 20
```


## skmer_query

### Tool Description
Compare an input genome-skim or assembly against a reference library

### Metadata
- **Docker Image**: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
- **Homepage**: https://github.com/shahab-sarmashghi/Skmer
- **Package**: https://anaconda.org/channels/bioconda/packages/skmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: skmer query [-h] [-a] [-o O] [-e E] [-t] [-p P] input library

Compare an input genome-skim or assembly against a reference library

positional arguments:
  input       Input (query) genome-skim or assembly (a
              .fastq/.fq/.fa/.fna/.fasta file)
  library     Directory of (reference) library

options:
  -h, --help  show this help message and exit
  -a          Add the processed input (query) to the (reference) library
  -o O        Output (distances) prefix. Default: dist
  -e E        Base error rate. By default, the error rate is automatically
              estimated.
  -t          Apply Jukes-Cantor transformation to distances. Output 5.0 if
              not applicable
  -p P        Max number of processors to use [1-20]. Default for this
              machine: 20
```


## skmer_subsample

### Tool Description
Performs subsample on a library of reference genome-skims or assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
- **Homepage**: https://github.com/shahab-sarmashghi/Skmer
- **Package**: https://anaconda.org/channels/bioconda/packages/skmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: skmer subsample [-h] [-sub SUB] [-fa] [-msh] [-k K] [-s S] [-S S]
                       [-i I] [-b B] [-c C] [-e E] [-t] [-p P]
                       input_dir

Performs subsample on a library of reference genome-skims or assemblies

positional arguments:
  input_dir   Directory of input genome-skims or assemblies (dir of
              .fastq/.fq/.fa/.fna/.fasta files)

options:
  -h, --help  show this help message and exit
  -sub SUB    Directory of output for subsample replicates. Default:
              working_directory/subsample
  -fa         Save subsampled genome-skims. Default: false
  -msh        Save sketches. Default: false
  -k K        K-mer length [1-31]. Default: 31
  -s S        Sketch size. Default: 100000
  -S S        Sketching random seed. Default: 42
  -i I        Start index of subsampled replicate (eg 5 for dir rep5).
              Default: 0
  -b B        Number of subsampled replicates. Default: 100
  -c C        Exponent value for subsampling. Default: 0.9
  -e E        Base error rate. By default, the error rate is automatically
              estimated.
  -t          Apply Jukes-Cantor transformation to distances. Output 5.0 if
              not applicable
  -p P        Max number of processors to use [1-20]. Default for this
              machine: 20
```


## skmer_correct

### Tool Description
Performs correction of subsampled distance matrices obtained for reference genome-skims or assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
- **Homepage**: https://github.com/shahab-sarmashghi/Skmer
- **Package**: https://anaconda.org/channels/bioconda/packages/skmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: skmer correct [-h] [-main MAIN] [-sub SUB] [-p P]

Performs correction of subsampled distance matrices obtained for reference
genome-skims or assemblies

options:
  -h, --help  show this help message and exit
  -main MAIN  Distance matrix of main estimate
  -sub SUB    Directory of output for subsample replicates. Default:
              working_directory/subsample
  -p P        Max number of processors to use [1-20]. Default for this
              machine: 20
```


## skmer_Run

### Tool Description
skmer: error: argument {commands}: invalid choice: 'Run' (choose from 'reference', 'subsample', 'correct', 'distance', 'query')

### Metadata
- **Docker Image**: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
- **Homepage**: https://github.com/shahab-sarmashghi/Skmer
- **Package**: https://anaconda.org/channels/bioconda/packages/skmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: skmer [-h] [--debug] {reference,subsample,correct,distance,query} ...
skmer: error: argument {commands}: invalid choice: 'Run' (choose from 'reference', 'subsample', 'correct', 'distance', 'query')
```


## Metadata
- **Skill**: generated
