# biasaway CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| biasaway_c | PASS |  |
| biasaway_g | PASS |  |
| biasaway_k | PASS |  |
| biasaway_w | PASS |  |

## biasaway_k

### Tool Description
k-mer shuffling generator

### Metadata
- **Docker Image**: quay.io/biocontainers/biasaway:3.3.0--py_0
- **Homepage**: https://github.com/asntech/biasaway
- **Package**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Total Downloads**: 35.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/asntech/biasaway
- **Stars**: N/A

### Original Help Text
```text
usage: biasaway k [-h] -f FG_FILE [-k KMER] [-n NFOLD] [-p PLOT_FILENAME]
                  [-e RANDOM_SEED]

optional arguments:
  -h, --help            show this help message and exit
  -f FG_FILE, --foreground FG_FILE
                        Foreground file in fasta format
  -k KMER, --kmer KMER  K-mer used for the shuffling (default: 2)
  -n NFOLD, --nfold NFOLD
                        How many background sequences per each foreground
                        sequence will be generated (default: 1)
  -p PLOT_FILENAME, --plot_filename PLOT_FILENAME
                        Basename for the QC plot and metric files (default: no
                        QC plot created)
  -e RANDOM_SEED, --seed RANDOM_SEED
                        Seed number to initialize the random number generator
```

## biasaway_w

### Tool Description
k-mer shuffling within a sliding window generator

### Metadata
- **Docker Image**: quay.io/biocontainers/biasaway:3.3.0--py_0
- **Homepage**: https://github.com/asntech/biasaway
- **Package**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Total Downloads**: 35.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/asntech/biasaway
- **Stars**: N/A

### Original Help Text
```text
usage: biasaway w [-h] -f FG_FILE [-k KMER] [-w WINLEN] [-s STEP] [-n NFOLD]
                  [-p PLOT_FILENAME] [-e RANDOM_SEED]

optional arguments:
  -h, --help            show this help message and exit
  -f FG_FILE, --foreground FG_FILE
                        Foreground file in fasta format
  -k KMER, --kmer KMER  K-mer used for the shuffling (default: 2
  -w WINLEN, --winlen WINLEN
                        Window length (default: 100)
  -s STEP, --step STEP  Sliding step (default: 50)
  -n NFOLD, --nfold NFOLD
                        How many background sequences per each foreground
                        sequence will be generated (default: 1)
  -p PLOT_FILENAME, --plot_filename PLOT_FILENAME
                        Basename for the QC plot and metric files (default: no
                        QC plot created)
  -e RANDOM_SEED, --seed RANDOM_SEED
                        Seed number to initialize the random number generator
```

## biasaway_g

### Tool Description
%GC distribution-based background chooser

### Metadata
- **Docker Image**: quay.io/biocontainers/biasaway:3.3.0--py_0
- **Homepage**: https://github.com/asntech/biasaway
- **Package**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Total Downloads**: 35.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/asntech/biasaway
- **Stars**: N/A

### Original Help Text
```text
usage: biasaway g [-h] -f FG_FILE -r BG_DIR [-b BG_FILE] [-n NFOLD] [-l]
                  [-p PLOT_FILENAME] [-e RANDOM_SEED]

optional arguments:
  -h, --help            show this help message and exit
  -f FG_FILE, --foreground FG_FILE
                        Foreground file in fasta format
  -r BG_DIR, --bgdirectory BG_DIR
                        Background directory (must be empty if --background is
                        used). See documentation for details.
  -b BG_FILE, --background BG_FILE
                        Background file in fasta format. Not necessary if a
                        backgrounddirectory has already been computed
                        previously.
  -n NFOLD, --nfold NFOLD
                        How many background sequences per each foreground
                        sequence will be choosen (default: 1)
  -l, --length          Try to match the length as closely as possible (not
                        set by default)
  -p PLOT_FILENAME, --plot_filename PLOT_FILENAME
                        Basename for the QC plot and metric files (default: no
                        QC plot created)
  -e RANDOM_SEED, --seed RANDOM_SEED
                        Seed number to initialize the random number generator
```

## biasaway_c

### Tool Description
%GC distribution and %GC composition within a sliding window background chooser

### Metadata
- **Docker Image**: quay.io/biocontainers/biasaway:3.3.0--py_0
- **Homepage**: https://github.com/asntech/biasaway
- **Package**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biasaway/overview
- **Total Downloads**: 35.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/asntech/biasaway
- **Stars**: N/A

### Original Help Text
```text
usage: biasaway c [-h] -f FG_FILE -r BG_DIR [-b BG_FILE] [-w WINLEN] [-s STEP]
                  [-d DEVIATION] [-n NFOLD] [-l] [-p PLOT_FILENAME]
                  [-e RANDOM_SEED]

optional arguments:
  -h, --help            show this help message and exit
  -f FG_FILE, --foreground FG_FILE
                        Foreground file in fasta format
  -r BG_DIR, --bgdirectory BG_DIR
                        Background directory (must be empty if --background is
                        used). See documentation for details.
  -b BG_FILE, --background BG_FILE
                        Background file in fasta format. Not necessary if a
                        backgrounddirectory has already been computed
                        previously.
  -w WINLEN, --winlen WINLEN
                        Window length (default: 100)
  -s STEP, --step STEP  Sliding step (default: 50)
  -d DEVIATION, --deviation DEVIATION
                        Deviation from the mean (default: 2.6 for a threshold
                        of mean + 2.6 * stdev)
  -n NFOLD, --nfold NFOLD
                        How many background sequences per each foreground
                        sequence will be choosen (default: 1)
  -l, --length          Try to match the length as closely as possible (not
                        set by default)
  -p PLOT_FILENAME, --plot_filename PLOT_FILENAME
                        Basename for the QC plot and metric files (default: no
                        QC plot created)
  -e RANDOM_SEED, --seed RANDOM_SEED
                        Seed number to initialize the random number generator
```

