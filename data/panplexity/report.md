# panplexity CWL Generation Report

## panplexity

### Tool Description
A tool for calculating complexity measures (linguistic or entropy) on GFA files and identifying low-complexity regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/panplexity:0.1.1--h3ab6199_0
- **Homepage**: https://github.com/AndreaGuarracino/panplexity
- **Package**: https://anaconda.org/channels/bioconda/packages/panplexity/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/panplexity/overview
- **Total Downloads**: 826
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/AndreaGuarracino/panplexity
- **Stars**: N/A
### Original Help Text
```text
Usage: panplexity [OPTIONS] --input-gfa <INPUT_GFA>

Options:
  -i, --input-gfa <INPUT_GFA>
          Input GFA file
  -w, --window-size <WINDOW_SIZE>
          Window size for complexity calculation [default: 100]
  -t, --threshold <THRESHOLD>
          Threshold for low-complexity regions (number or "auto") [default: auto]
      --iqr-multiplier <IQR_MULTIPLIER>
          IQR multiplier for automatic threshold (default: 1.5, use with threshold "auto") [default: 1.5]
      --complexity <COMPLEXITY>
          Complexity measure type: "linguistic" or "entropy" (default: "linguistic") [default: linguistic]
  -k, --k-mer <K>
          K-mer size (used with linguistic complexity) [default: 16]
  -s, --step-size <STEP_SIZE>
          Step size for sliding window (used with entropy complexity) [default: 50]
  -d, --distance <MERGE_THRESHOLD>
          Distance threshold for merging close ranges [default: 100]
  -o, --output-gfa <OUTPUT_GFA>
          Output annotated GFA file
  -b, --bed <BED>
          Output BED file with low-complexity ranges
  -c, --csv <CSV>
          Output CSV file for Bandage node coloring (Node,Colour format)
  -m, --mask <MASK>
          Output boolean mask file: 1 if node is not annotated, 0 if annotated
      --weights <WEIGHTS>
          Output weights file: node_id and its associated complexity/entropy weight
  -v, --verbose <VERBOSE>
          Verbosity level (0: errors only, 1: errors and info, 2: debug, 3: trace) [default: 1]
      --threads <THREADS>
          Number of threads to use for parallel processing [default: 4]
  -h, --help
          Print help
  -V, --version
          Print version
```


## Metadata
- **Skill**: generated
