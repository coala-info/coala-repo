# pycov3 CWL Generation Report

## pycov3

### Tool Description
Calculate coverage from SAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycov3:2.1.1--pyh7e72e81_0
- **Homepage**: https://github.com/Ulthran/pycov3
- **Package**: https://anaconda.org/channels/bioconda/packages/pycov3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pycov3/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2026-02-06
- **GitHub**: https://github.com/Ulthran/pycov3
- **Stars**: N/A
### Original Help Text
```text
usage: pycov3 [-h] [-S SAM_DIR] [-F FASTA_DIR] [-O OUT_DIR] [-X]
              [-W WINDOW_SIZE] [-D WINDOW_STEP] [-M MAPQ_CUTOFF]
              [-L MAPL_CUTOFF] [-R MAX_MISMATCH_RATIO] [-T THREAD_NUM]
              [-G LOG_LEVEL] [-V]

options:
  -h, --help            show this help message and exit
  -S, --sam_dir SAM_DIR
                        the directory containing the sam file(s)
  -F, --fasta_dir FASTA_DIR
                        the directory containing the binned fasta file(s)
  -O, --out_dir OUT_DIR
                        the output directory
  -X, --overwrite       overwrites any existing outputs
  -W, --window_size WINDOW_SIZE
                        size (nt) of window for calculation of coverage
                        (default: 5000)
  -D, --window_step WINDOW_STEP
                        step (nt) of window for calculation of coverage
                        (default: 100)
  -M, --mapq_cutoff MAPQ_CUTOFF
                        cutoff of mapping quality when calculating coverages
                        (default: 5)
  -L, --mapl_cutoff MAPL_CUTOFF
                        cutoff of mapping length when calculating coverages
                        (default: 50)
  -R, --max_mismatch_ratio MAX_MISMATCH_RATIO
                        maximum of mismatch ratio for each read as a hit
                        (default: 0.03)
  -T, --thread_num THREAD_NUM
                        set number of threads for parallel running (default:
                        1)
  -G, --log_level LOG_LEVEL
                        Sets the log level, default is info, 10 for debug
                        (Default: 20)
  -V, -v, --version     show program's version number and exit
```

