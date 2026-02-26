# savont CWL Generation Report

## savont_asv

### Tool Description
Cluster long reads of >~ 98% accuracy into ASVs (Amplicon Sequence Variants)

### Metadata
- **Docker Image**: quay.io/biocontainers/savont:0.3.2--h3ab6199_0
- **Homepage**: https://github.com/bluenote-1577/savont
- **Package**: https://anaconda.org/channels/bioconda/packages/savont/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/savont/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/bluenote-1577/savont
- **Stars**: N/A
### Original Help Text
```text
Cluster long reads of >~ 98% accuracy into ASVs (Amplicon Sequence Variants)

Usage: savont asv [OPTIONS] <FASTQ/FASTA>...

Arguments:
  <FASTQ/FASTA>...  Input read file(s) in FASTQ or FASTA format (.gz supported). Multiple files are concatenated

Options:
  -o, --output-dir <OUTPUT_DIR>  Output directory for results (created if it does not exist) [default: savont-out]
  -t, --threads <THREADS>        Number of threads to use for parallel processing [default: 20]
  -l, --log-level <LOG_LEVEL>    Logging verbosity level [default: debug] [possible values: error, warn, info, debug, trace]
  -h, --help                     Print help

Parameter Presets:
      --fl-16s       16s rRNA full length (~1500 bp) amplicon preset (default; does nothing)
      --rrna-operon  rRNA operon (~4000 bp) amplicon preset (--min-read-length 3500 --max-read-length 5000)

Input/Output Options:
      --min-read-length <MIN_READ_LENGTH>
          Minimum read length for reads [default: 1100]
      --max-read-length <MAX_READ_LENGTH>
          Maximum read length for reads [default: 2000]
      --quality-value-cutoff <QUALITY_VALUE_CUTOFF>
          Minimum estimated read accuracy (%) to include in clustering [default: 98]
      --minimum-base-quality <MINIMUM_BASE_QUALITY>
          Minimum base quality to be considered high-quality for SNPmer detection. Set lower for older reads (~18 for R9) [default: 25]

Clustering Parameters:
  -s, --single-strand
          Use only forward strand k-mers (for strand-specific protocols)
      --min-cluster-size <MIN_CLUSTER_SIZE>
          Minimum number of reads required to keep a cluster (ASV) [default: 12]
      --max-iterations-recluster <MAX_ITERATIONS_RECLUSTER>
          Maximum number of reclustering iterations [default: 10]

Consensus Parameters:
  -n, --n-depth-cutoff <N_DEPTH_CUTOFF>
          Minimum depth required for sequences with ambiguous bases to be included in output [default: 250]
      --mask-low-quality
          Mask low-quality bases in consensus sequences (set to 'N' if below posterior probability threshold)
  -p, --posterior-threshold-ln <POSTERIOR_THRESHOLD_LN>
          Negative alternate posterior probability threshold (natural log scale) for base consensus. Higher = more stringent for low-quality consensuses. Do not set higher than min_depth * ln(error_rate) [default: 30]

Chimera Detection Options:
      --chimera-allowable-errors <CHIMERA_ALLOWABLE_ERRORS>
          Allowable errors for bi-chimeric detection (higher = more sensitive, slower) [default: 1]
      --chimera-detect-length <CHIMERA_DETECT_LENGTH>
          Length of near-perfect asv segment matches to consider for chimera detection (higher = less sensitive). Default is 1/10 of the minimum read length
```


## savont_classify

### Tool Description
Classify ASVs against a reference database and generate taxonomy abundance table at species/genus level

### Metadata
- **Docker Image**: quay.io/biocontainers/savont:0.3.2--h3ab6199_0
- **Homepage**: https://github.com/bluenote-1577/savont
- **Package**: https://anaconda.org/channels/bioconda/packages/savont/overview
- **Validation**: PASS

### Original Help Text
```text
Classify ASVs against a reference database and generate taxonomy abundance table at species/genus level

Usage: savont classify [OPTIONS] --input-dir <INPUT_DIR> <--emu-db <EMU_DB>|--silva-db <SILVA_DB>>

Options:
  -i, --input-dir <INPUT_DIR>
          Directory containing clustering results
  -o, --output-dir <OUTPUT_DIR>
          Output directory for classification results. Default: same as the input directory
  -l, --log-level <LOG_LEVEL>
          Logging verbosity level [default: debug] [possible values: error, warn, info, debug, trace]
  -t, --threads <THREADS>
          Number of threads to use for parallel processing [default: 20]
      --species-threshold <SPECIES_THRESHOLD>
          Minimum identity threshold for species-level classification (default: 99%) [default: 99]
      --genus-threshold <GENUS_THRESHOLD>
          Minimum identity threshold for genus-level classification (default: 94.5%) [default: 94.5]
  -h, --help
          Print help

Database:
      --emu-db <EMU_DB>      Emu database path
      --silva-db <SILVA_DB>  SILVA database path
```


## savont_download

### Tool Description
Download reference databases for savont (EMU or SILVA)

### Metadata
- **Docker Image**: quay.io/biocontainers/savont:0.3.2--h3ab6199_0
- **Homepage**: https://github.com/bluenote-1577/savont
- **Package**: https://anaconda.org/channels/bioconda/packages/savont/overview
- **Validation**: PASS

### Original Help Text
```text
Download reference databases for savont (EMU or SILVA)

Usage: savont download [OPTIONS] --location <LOCATION> <--emu-db|--silva-db>

Options:
  -l, --location <LOCATION>    Download location directory
      --emu-db                 Download EMU database
      --silva-db               Download SILVA database
  -l, --log-level <LOG_LEVEL>  Logging verbosity level [default: debug] [possible values: error, warn, info, debug, trace]
  -h, --help                   Print help
```

