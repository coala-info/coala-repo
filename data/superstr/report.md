# superstr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| superstr | PASS |  |
| superstr_superstr-multiparse.py | PASS | the CWL writes a manifest copy with absolute paths because the script compares absolute paths with the manifest text |
| superstr_superstr-outliers.py | PASS |  |
| superstr_superstr-screen.py | Failed | image problem: script crashes with AttributeError, DataFrame has no attribute append (pandas 2 in the image) |
| superstr_superstr-visualise.py | Failed | image problem: script crashes with AttributeError, DataFrame has no attribute append (pandas 2 in the image) |

## superstr

### Tool Description
Rapid STR characterisation in NGS data.

### Metadata
- **Docker Image**: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
- **Homepage**: https://github.com/bahlolab/superSTR
- **Package**: https://anaconda.org/channels/bioconda/packages/superstr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/superstr/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bahlolab/superSTR
- **Stars**: N/A
### Original Help Text
```text
Usage: superstr
 [-s] [--help] [--version] [--mode=<fastq|bam>] [-o myfile] [<file>]... [-t float] [-r <int>]
Rapid STR characterisation in NGS data.
  --help                    display this help and exit
  --version                 display version info and exit
  --mode=<fastq|bam>        type of input data
  -s, --stream              run on named streams, not files (see manual for instructions)
  -o myfile                 output directory
  <file>                    input files (or names of pipes in stream mode)
  -t, --threshold=float     compression threshold for processing strings
  -r, --retain=<int>        write retained reads
```

## superstr_superstr-multiparse.py

### Tool Description
superSTR multiparse step

### Metadata
- **Docker Image**: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
- **Homepage**: https://github.com/bahlolab/superSTR
- **Package**: https://anaconda.org/channels/bioconda/packages/superstr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: superstr-multiparse.py [-h] -m MANIFEST_PATH --output OUTPUT_PATH
                              [--clobber] [-r READ_LENGTH] [-@ THREADCOUNT]

options:
  -h, --help            show this help message and exit

File paths:
  -m, --manifest MANIFEST_PATH
                        Manifest path
  --output OUTPUT_PATH  Output path for files.

Optional arguments:
  --clobber             Clobber existing files.
  -r, --readlength READ_LENGTH
                        Manually set read length (default 150nt).
  -@, --threads THREADCOUNT
                        Number of threads for multiparser execution
                        (default=4)
```

## superstr_superstr-outliers.py

### Tool Description
superSTR outliers step

### Metadata
- **Docker Image**: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
- **Homepage**: https://github.com/bahlolab/superSTR
- **Package**: https://anaconda.org/channels/bioconda/packages/superstr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: superstr-outliers.py [-h] [-i INPUT_PATH] [-o OUTPUT_PATH]
                            [-m MANIFEST] [-v] [--pathogenic]
                            [--max_motif MAX_MOTIF] [--motifs MOTIFS]
                            [--bootstrapCI] [-pc PC] [-lb] [--rl READ_LENGTH]
                            [--controllab CTRLLAB] [--failover] [-is] [-ml]
                            [--min_len MIN_LEN] [--max_len MAX_LEN]

options:
  -h, --help            show this help message and exit

Global options.:
  -i INPUT_PATH         Input path; should be a directory containing one or
                        more superSTR runs.
  -o OUTPUT_PATH        Output path for files. If not set, output to stdout.
  -m MANIFEST           Path to manifest file (optional)
  -v, --verbose         Enable verbose mode.

Motif targeting options::
  --pathogenic          Perform outlier detection in only known pathogenic
                        motifs.
  --max_motif MAX_MOTIF
                        Set the maximum motif length to run outlier
                        calculations to.
  --motifs MOTIFS       Path to a file containing motifs of interest; one line
                        per motif.

Outlier detection methods:
  --bootstrapCI         Generate outlier calls against a specified the 95% CI
                        estimate of a percentile using the ABC bootstrap

Bootstrapped percentile CI options:
  -pc PC                Percentile for estimation; must be between 0.0 and 1.0
  -lb                   Use lower-bound of 95% CI estimate (default is to use
                        upper)
  --rl READ_LENGTH      Manually set read length.
  --controllab CTRLLAB  Label for control data
  --failover            Automatically fail over to the percentile bootstrap.

Metrics and metric options:
  -is, --info_score     Test for outliers in size-weighted repeat score
  -ml, --max_length     Test for outliers in max-length reads only
  --min_len MIN_LEN     Minimum length for information score calculation
  --max_len MAX_LEN     Maximum length for information score calculation
```

## superstr_superstr-screen.py

### Tool Description
superSTR screen step

### Metadata
- **Docker Image**: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
- **Homepage**: https://github.com/bahlolab/superSTR
- **Package**: https://anaconda.org/channels/bioconda/packages/superstr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: superstr-screen.py [-h] [-m MANIFEST] [-o OUTPUT] [-i INPUT]
                          [--label DF_STRING] [--controllab CTRL_LABEL]
                          [--swaplabs] [-@ NPROCS] [--min_motif MIN_MOTIF]
                          [--max_motif MAX_MOTIF] [-p N_PERMUTATIONS]
                          [--min_thresh MIN_THRESH]

options:
  -h, --help            show this help message and exit
  -m MANIFEST           path to manifest file
  -o OUTPUT             output prefix
  -i INPUT              input path
  --label DF_STRING     column label to use for group status
  --controllab CTRL_LABEL
                        label used for controls
  --swaplabs            use manifest file labels
  -@ NPROCS             Number of processes (default 6)
  --min_motif MIN_MOTIF
                        Minimum motif length (inclusive, default 3)
  --max_motif MAX_MOTIF
                        Maximum motif length (inclusive, default 6)
  -p N_PERMUTATIONS     Number of permutations (default 10,000)
  --min_thresh MIN_THRESH
                        Minimum number of samples for a group to be tested
```

## superstr_superstr-visualise.py

### Tool Description
superSTR visualise step

### Metadata
- **Docker Image**: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
- **Homepage**: https://github.com/bahlolab/superSTR
- **Package**: https://anaconda.org/channels/bioconda/packages/superstr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: superstr-visualise.py [-h] [-m MANIFEST] [-o OUTPUT] [-i INPUT]
                             [-fh FIG_HEIGHT] [-fw FIG_WIDTH]
                             [--aff_col AFF_COL] [--ctrl_col CTRL_COL]
                             [--ctrl_lab CTRL_LAB] [--aff_lab AFF_LAB]

options:
  -h, --help           show this help message and exit
  -m MANIFEST          path to manifest file
  -o OUTPUT            output prefix; matplotlib will try and save the file in
                       the format specified by the extension (PDF, PNG etc)
  -i INPUT             input path
  -fh FIG_HEIGHT       figure height (inches) (default: 8.97638)
  -fw FIG_WIDTH        figure width (inches) (default: 6.49606)
  --aff_col AFF_COL    color for affected group; matplotlib color or hex (e.g.
                       'lightgrey' or '#3B6978'. Defaults to '#3B6978'
  --ctrl_col CTRL_COL  color for control/background group; matplotlib color or
                       hex (e.g. 'lightgrey' or '#3B6978'. Defaults to
                       'lightgrey'
  --ctrl_lab CTRL_LAB  label for control/background group; case sensitive
  --aff_lab AFF_LAB    label for affected group; case sensitive
```

