# barbell CWL Generation Report

## barbell_annotate

### Tool Description
Annotate FASTQ files with barcode information

### Metadata
- **Docker Image**: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
- **Homepage**: https://github.com/rickbeeloo/barbell
- **Package**: https://anaconda.org/channels/bioconda/packages/barbell/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/barbell/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2026-01-21
- **GitHub**: https://github.com/rickbeeloo/barbell
- **Stars**: N/A
### Original Help Text
```text
██████╗  █████╗ ██████╗ ██████╗ ███████╗██╗     ██╗     
    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██║     ██║     
    ██████╔╝███████║██████╔╝██████╔╝█████╗  ██║     ██║     
    ██╔══██╗██╔══██║██╔══██╗██╔══██╗██╔══╝  ██║     ██║     
    ██████╔╝██║  ██║██║  ██║██████╔╝███████╗███████╗███████╗
    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝
    
        [===]------------------------------------------[===]        
Annotate FASTQ files with barcode information

Usage: barbell annotate [OPTIONS] --input <INPUT>

Options:
  -i, --input <INPUT>
          Input FASTQ file
  -t, --threads <THREADS>
          Number of threads [default: 10]
  -o, --output <OUTPUT>
          Output file path [default: output.tsv]
  -q, --queries <QUERIES>
          Query files (comma-separated paths)
  -b, --barcode-types <BARCODE_TYPES>
          Barcode types (comma-separated: Ftag,Rtag) matching your query file (-q) [default: Ftag]
      --kit <KIT>
          Kit name (e.g. SQK-RBK114-24). Conflicts with --queries/--barcode-types
      --flank-max-errors <INT>
          Flank maximum erors in flank, ONLY set manually when you know what you are doing
      --verbose
          Enable verbose output for debugging
      --min-score <MIN_SCORE>
          Barcode: fraction compared to 'perfect' match score for top candidate [default: 0.2]
      --min-score-diff <MIN_SCORE_DIFF>
          Barcode: fraction difference between top 2 candidates [default: 0.1]
      --use-extended
          Also use extended templates (if using kit), i.e. detect fusions, breaks, etc. (slower)
      --alpha <ALPHA>
          Edit cost beyond read boundaries [default: 0.4]
  -h, --help
          Print help
```


## barbell_filter

### Tool Description
Filter annotation files based on pattern

### Metadata
- **Docker Image**: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
- **Homepage**: https://github.com/rickbeeloo/barbell
- **Package**: https://anaconda.org/channels/bioconda/packages/barbell/overview
- **Validation**: PASS

### Original Help Text
```text
██████╗  █████╗ ██████╗ ██████╗ ███████╗██╗     ██╗     
    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██║     ██║     
    ██████╔╝███████║██████╔╝██████╔╝█████╗  ██║     ██║     
    ██╔══██╗██╔══██║██╔══██╗██╔══██╗██╔══╝  ██║     ██║     
    ██████╔╝██║  ██║██║  ██║██████╔╝███████╗███████╗███████╗
    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝
    
        [===]------------------------------------------[===]        
Filter annotation files based on pattern

Usage: barbell filter [OPTIONS] --input <INPUT> --output <OUTPUT> --file <FILE>

Options:
  -i, --input <INPUT>      Input annotation file
  -o, --output <OUTPUT>    Output filtered file path
  -f, --file <FILE>        File containing patterns to filter by
      --dropped <DROPPED>  Write dropped read annotation to this file
  -h, --help               Print help
```


## barbell_trim

### Tool Description
Trim and sort reads based on filtered annotations

### Metadata
- **Docker Image**: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
- **Homepage**: https://github.com/rickbeeloo/barbell
- **Package**: https://anaconda.org/channels/bioconda/packages/barbell/overview
- **Validation**: PASS

### Original Help Text
```text
██████╗  █████╗ ██████╗ ██████╗ ███████╗██╗     ██╗     
    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██║     ██║     
    ██████╔╝███████║██████╔╝██████╔╝█████╗  ██║     ██║     
    ██╔══██╗██╔══██║██╔══██╗██╔══██╗██╔══╝  ██║     ██║     
    ██████╔╝██║  ██║██║  ██║██████╔╝███████╗███████╗███████╗
    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝
    
        [===]------------------------------------------[===]        
Trim and sort reads based on filtered annotations

Usage: barbell trim [OPTIONS] --input <INPUT> --reads <READS> --output <OUTPUT>

Options:
  -i, --input <INPUT>            Input filtered annotation file
  -r, --reads <READS>            Read FASTQ file
  -o, --output <OUTPUT>          Output folder path for trimmed reads
      --no-label                 Disable label in output filenames
      --no-orientation           Disable orientation in output filenames
      --no-flanks                Disable flank in output filenames
      --sort-labels              Sort barcode labels in output filenames
      --only-side <ONLY_SIDE>    Only keep left or right label in output filenames [possible values: left, right]
      --failed-out <FAILED_OUT>  Write ids of failed trimmed reads to this file
  -h, --help                     Print help
```


## barbell_inspect

### Tool Description
View most common patterns in annotation

### Metadata
- **Docker Image**: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
- **Homepage**: https://github.com/rickbeeloo/barbell
- **Package**: https://anaconda.org/channels/bioconda/packages/barbell/overview
- **Validation**: PASS

### Original Help Text
```text
██████╗  █████╗ ██████╗ ██████╗ ███████╗██╗     ██╗     
    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██║     ██║     
    ██████╔╝███████║██████╔╝██████╔╝█████╗  ██║     ██║     
    ██╔══██╗██╔══██║██╔══██╗██╔══██╗██╔══╝  ██║     ██║     
    ██████╔╝██║  ██║██║  ██║██████╔╝███████╗███████╗███████╗
    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝
    
        [===]------------------------------------------[===]        
View most common patterns in annotation

Usage: barbell inspect [OPTIONS] --input <INPUT>

Options:
  -i, --input <INPUT>
          Input filtered annotation file
  -n, --top-n <TOP_N>
          Top N [default: 10]
  -o, --read-pattern-out <READ_PATTERN_OUT>
          Write pattern for each read to this file (optional)
  -s, --bucket-size <BUCKET_SIZE>
          To summarize results we uses "buckets", such that matches 100 and 103 from the start end up in the same bucket [default: 250]
  -h, --help
          Print help
```


## barbell_kit

### Tool Description
Run a preset

### Metadata
- **Docker Image**: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
- **Homepage**: https://github.com/rickbeeloo/barbell
- **Package**: https://anaconda.org/channels/bioconda/packages/barbell/overview
- **Validation**: PASS

### Original Help Text
```text
██████╗  █████╗ ██████╗ ██████╗ ███████╗██╗     ██╗     
    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔════╝██║     ██║     
    ██████╔╝███████║██████╔╝██████╔╝█████╗  ██║     ██║     
    ██╔══██╗██╔══██║██╔══██╗██╔══██╗██╔══╝  ██║     ██║     
    ██████╔╝██║  ██║██║  ██║██████╔╝███████╗███████╗███████╗
    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝
    
        [===]------------------------------------------[===]        
Run a preset

Usage: barbell kit [OPTIONS] --kit <KIT> --input <INPUT> --output <OUTPUT>

Options:
  -k, --kit <KIT>
          Kit to use (e.g. SQK-RBK114-24)
  -i, --input <INPUT>
          Input FASTQ file
  -t, --threads <THREADS>
          Number of threads [default: 10]
  -o, --output <OUTPUT>
          Output folder
      --maximize
          Add more 'risky' patterns to demuxing to maximize assigned reads
      --verbose
          Enable verbose output for debugging
      --min-score <MIN_SCORE>
          Fraction compared to 'perfect' match score for top candidate [default: 0.2]
      --min-score-diff <MIN_SCORE_DIFF>
          Fraction difference between top 2 candidates [default: 0.1]
      --flank-max-errors <INT>
          Flank maximum erors in flank, ONLY set manually when you know what you are doing
      --failed-out <FAILED_OUT>
          Write ids of failed trimmed reads to this file
      --use-extended
          Also use extended templates (if using kit), i.e. detect fusions, breaks, etc. (slower)
      --alpha <ALPHA>
          Edit cost beyond read boundaries [default: 0.4]
  -h, --help
          Print help
```


## Metadata
- **Skill**: generated
