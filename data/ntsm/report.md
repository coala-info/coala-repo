# ntsm CWL Generation Report

## ntsm_ntsmSiteGen

### Tool Description
GNU Make is a tool which controls the generation of programs and other non-source files from a description file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
- **Homepage**: https://github.com/JustinChu/ntsm
- **Package**: https://anaconda.org/channels/bioconda/packages/ntsm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ntsm/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/JustinChu/ntsm
- **Stars**: N/A
### Original Help Text
```text
Usage: make [options] [target] ...
Options:
  -b, -m                      Ignored for compatibility.
  -B, --always-make           Unconditionally make all targets.
  -C DIRECTORY, --directory=DIRECTORY
                              Change to DIRECTORY before doing anything.
  -d                          Print lots of debugging information.
  --debug[=FLAGS]             Print various types of debugging information.
  -e, --environment-overrides
                              Environment variables override makefiles.
  -E STRING, --eval=STRING    Evaluate STRING as a makefile statement.
  -f FILE, --file=FILE, --makefile=FILE
                              Read FILE as a makefile.
  -h, --help                  Print this message and exit.
  -i, --ignore-errors         Ignore errors from recipes.
  -I DIRECTORY, --include-dir=DIRECTORY
                              Search DIRECTORY for included makefiles.
  -j [N], --jobs[=N]          Allow N jobs at once; infinite jobs with no arg.
  --jobserver-style=STYLE     Select the style of jobserver to use.
  -k, --keep-going            Keep going when some targets can't be made.
  -l [N], --load-average[=N], --max-load[=N]
                              Don't start multiple jobs unless load is below N.
  -L, --check-symlink-times   Use the latest mtime between symlinks and target.
  -n, --just-print, --dry-run, --recon
                              Don't actually run any recipe; just print them.
  -o FILE, --old-file=FILE, --assume-old=FILE
                              Consider FILE to be very old and don't remake it.
  -O[TYPE], --output-sync[=TYPE]
                              Synchronize output of parallel jobs by TYPE.
  -p, --print-data-base       Print make's internal database.
  -q, --question              Run no recipe; exit status says if up to date.
  -r, --no-builtin-rules      Disable the built-in implicit rules.
  -R, --no-builtin-variables  Disable the built-in variable settings.
  --shuffle[={SEED|random|reverse|none}]
                              Perform shuffle of prerequisites and goals.
  -s, --silent, --quiet       Don't echo recipes.
  --no-silent                 Echo recipes (disable --silent mode).
  -S, --no-keep-going, --stop
                              Turns off -k.
  -t, --touch                 Touch targets instead of remaking them.
  --trace                     Print tracing information.
  -v, --version               Print the version number of make and exit.
  -w, --print-directory       Print the current directory.
  --no-print-directory        Turn off -w, even if it was turned on implicitly.
  -W FILE, --what-if=FILE, --new-file=FILE, --assume-new=FILE
                              Consider FILE to be infinitely new.
  --warn-undefined-variables  Warn when an undefined variable is referenced.

This program built for x86_64-conda-linux-gnu
Report bugs to <bug-make@gnu.org>
```


## ntsm_ntsmCount

### Tool Description
Count k-mers for SNP sites

### Metadata
- **Docker Image**: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
- **Homepage**: https://github.com/JustinChu/ntsm
- **Package**: https://anaconda.org/channels/bioconda/packages/ntsm/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntsmCount -s [FASTA] [OPTION]... [FILES...]
  -t, --threads = INT    Number of threads to run.[1]
  -m, --maxCov = INT     k-mer coverage threshold for early
                         termination. [inf]
  -o, --output = STR     Output for summary file.
  -d, --dupes            Allow shared k-mers between sites to
                         be counted.
  -s, --snp = STR        Interleaved fasta of SNP sites to
                         k-merize. [required]
  -k, --kmer = INT       k-mer size used. [19]
  -h, --help             Display this dialog.
  -v, --verbose          Display verbose output.
      --version          Print version information.
```


## ntsm_ntsmEval

### Tool Description
Processes sets of counts files and compares their similarity. If only a single file is provided general QC information returned.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
- **Homepage**: https://github.com/JustinChu/ntsm
- **Package**: https://anaconda.org/channels/bioconda/packages/ntsm/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntsmEval [FILES...]
Processes sets of counts files and compares their similarity.
If only a single file is provided general QC information returned.
  -t, --threads              Number of threads to run.[1]
  -s, --score_thresh = FLOAT Score threshold [0.500000]
  -a, --all                  Output results of all tests tried, not just those that
                             pass the score threshold.
  -w, --skew = FLOAT         Divides the score by coverage. Formula: (cov1*cov2)^skew
                             Set to zero for no skew.[0.200000]
  -c, --min_cov = INT        Keep only sites with this coverage and above.[1]
  -g, --genome_size = INT    Diploid genome size for error rate estimation.
                             [6200000000]
  -e, --merge = STR          After analysis merge counts and output to file.
  -o, --only_merge           Do not perform an analysis. Only functions when
                             -e (--merge) option is specified.
  -p, --pca = STR            Use PCA information to speed up analysis. Input is a
                             set of rotational values from a PCA.
  -d, --dim = INT            Number of dimensions to consider in PCA. [20]
  -n, --norm = STR           Set of values use to center the data before rotation
                             during PCA. [Required if -p is enabled]
  -r, --error_rate = FLOAT   Error rate threshold for PCA based search [0.010000]
  -1, --miss_small = FLOAT   Missing site threshold small for PCA based search [0.010000]
  -2, --miss_large = FLOAT   Missing site threshold large PCA based search [0.300000]
  -S, --small = FLOAT        Search radius for small PCA based search [2.000000]
  -l, --large = FLOAT        Search radius for large PCA based search [15.000000]
  -h, --help                 Display this dialog.
  -v, --verbose              Display verbose output.
      --version              Print version information.
```


## Metadata
- **Skill**: generated
