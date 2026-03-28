# seqsizzle CWL Generation Report

## seqsizzle_summarize

### Tool Description
Summarize the reads with patterns specified by the --patterns argument or the adapter flags. Make sure you supply the flags BEFORE the subcommand, e.g. `./SeqSizzle my.fastq -p my_patterns.csv --adapter-3p summarize`. '..' indicats unmatched regions of positive length, '-' indicates the patterns are overlapped, print the number of reads that match each pattern combination in TSV format. To be moved to the UI in the future

### Metadata
- **Docker Image**: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
- **Homepage**: https://github.com/ChangqingW/SeqSizzle
- **Package**: https://anaconda.org/channels/bioconda/packages/seqsizzle/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqsizzle/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2026-01-24
- **GitHub**: https://github.com/ChangqingW/SeqSizzle
- **Stars**: N/A
### Original Help Text
```text
Summarize the reads with patterns specified by the --patterns argument or the adapter flags. Make sure you supply the flags BEFORE the subcommand, e.g. `./SeqSizzle my.fastq -p my_patterns.csv --adapter-3p summarize`. '..' indicats unmatched regions of positive length, '-' indicates the patterns are overlapped, print the number of reads that match each pattern combination in TSV format. To be moved to the UI in the future

Usage: seqsizzle <FILE> summarize [OPTIONS]

Options:
      --counts  Print the counts of each summarized catagory instead of the percentage
  -h, --help    Print help
```


## seqsizzle_enrich

### Tool Description
Find enriched k-mers in the reads. This can be used to identify potential adapter/primer sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
- **Homepage**: https://github.com/ChangqingW/SeqSizzle
- **Package**: https://anaconda.org/channels/bioconda/packages/seqsizzle/overview
- **Validation**: PASS

### Original Help Text
```text
Find enriched k-mers in the reads. This can be used to identify potential adapter/primer sequences

Usage: seqsizzle <FILE> enrich [OPTIONS] --output <OUTPUT>

Options:
  -o, --output <OUTPUT>
          Path to write the output CSV file
      --max-reads <MAX_READS>
          Limit the total number of reads used for enrichment. Set to 0 to use all reads [default: 10000]
      --sample
          If set, randomly sample `--max-reads` reads from the file instead of taking the first N. Requires `--max-reads`
      --k-min <K_MIN>
          Minimum k-mer length to check [default: 8]
      --k-max <K_MAX>
          Maximum k-mer length to check [default: 12]
      --k-step <K_STEP>
          Step size between k-values (arithmetic progression) [default: 2]
      --top-kmers <TOP_KMERS>
          Number of top k-mers to keep per k value [default: 400]
      --substring-count-ratio-threshold <SUBSTRING_COUNT_RATIO_THRESHOLD>
          Substring filtering counts ratio threshold. For k-mers that are contained within longer k-mers, those with (shorter k-mer count) / (longer k-mer count) >= this threshold will be removed. For homopolymer k-mers, the threshold is lowered to threshold^4 [default: 0.8]
      --min-count <MIN_COUNT>
          Minimum counts per read threshold for k-mers (overrides z-score if provided). Accepts fractional values (e.g., 0.01 for 1 count per 100 reads)
      --z-score-threshold <Z_SCORE_THRESHOLD>
          Z-score threshold for k-mer enrichment (default: 5.0) [default: 5]
      --skip-assemble
          Perform assembly with k_max k-mers
      --detect-reverse-complement
          Detect and merge reverse complement k-mers
  -h, --help
          Print help
```


## seqsizzle_Start

### Tool Description
A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
- **Homepage**: https://github.com/ChangqingW/SeqSizzle
- **Package**: https://anaconda.org/channels/bioconda/packages/seqsizzle/overview
- **Validation**: PASS

### Original Help Text
```text
A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently.

Usage: seqsizzle [OPTIONS] <FILE> [COMMAND]

Commands:
  summarize  Summarize the reads with patterns specified by the --patterns argument or the adapter flags. Make sure you supply the flags BEFORE the subcommand, e.g. `./SeqSizzle my.fastq -p my_patterns.csv --adapter-3p summarize`. '..' indicats unmatched regions of positive length, '-' indicates the patterns are overlapped, print the number of reads that match each pattern combination in TSV format. To be moved to the UI in the future
  enrich     Find enriched k-mers in the reads. This can be used to identify potential adapter/primer sequences
  help       Print this message or the help of the given subcommand(s)

Arguments:
  <FILE>  The FASTQ or FASTA file to view (supports .fastq, .fasta, .fa, .fq and their .gz variants)

Options:
      --adapter-3p
          Start with 10x 3' kit adaptors:
           - Patrial Read1: CTACACGACGCTCTTCCGATCT (and reverse complement)
           - Partial TSO: CCCATGTACTCTGCGTTGATACCA (and reverse complement)
           - Poly(>10)A/T
      --adapter-5p
          Start with 10x 5' kit adaptors
           - Patrial Read1: CTACACGACGCTCTTCCGATCT (and reverse complement)
           - Patrial Read2: AGATCGGAAGAGCACACGTCTGAA (and reverse complement)
           - TSO: TTTCTTATATGGG (and reverse complement)
           - Poly(>10)A/T
  -p, --patterns <PATTERNS_PATH>
          Start with patterns from a CSV file
          Must have the following header:
          pattern,color,editdistance,comment
  -s, --save-patterns <SAVE_PATTERNS_PATH>
          Save the search panel to a CSV file before quitting. To be removed in the future since you can now hit Ctrl-S in the search panel to save the patterns
      --quality-italic
          Enable italic styling for low quality bases (enabled by default)
      --no-quality-italic
          Disable italic styling for low quality bases
      --quality-threshold <QUALITY_THRESHOLD>
          Quality threshold for styling [default: 10]
      --quality-colors
          Enable background color styling based on quality scores. You will probably have a hard time distinguishing forground colors from background colors, so this is disabled by default
  -h, --help
          Print help
  -V, --version
          Print version
```


## seqsizzle_Save

### Tool Description
A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
- **Homepage**: https://github.com/ChangqingW/SeqSizzle
- **Package**: https://anaconda.org/channels/bioconda/packages/seqsizzle/overview
- **Validation**: PASS

### Original Help Text
```text
A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently.

Usage: seqsizzle [OPTIONS] <FILE> [COMMAND]

Commands:
  summarize  Summarize the reads with patterns specified by the --patterns argument or the adapter flags. Make sure you supply the flags BEFORE the subcommand, e.g. `./SeqSizzle my.fastq -p my_patterns.csv --adapter-3p summarize`. '..' indicats unmatched regions of positive length, '-' indicates the patterns are overlapped, print the number of reads that match each pattern combination in TSV format. To be moved to the UI in the future
  enrich     Find enriched k-mers in the reads. This can be used to identify potential adapter/primer sequences
  help       Print this message or the help of the given subcommand(s)

Arguments:
  <FILE>  The FASTQ or FASTA file to view (supports .fastq, .fasta, .fa, .fq and their .gz variants)

Options:
      --adapter-3p
          Start with 10x 3' kit adaptors:
           - Patrial Read1: CTACACGACGCTCTTCCGATCT (and reverse complement)
           - Partial TSO: CCCATGTACTCTGCGTTGATACCA (and reverse complement)
           - Poly(>10)A/T
      --adapter-5p
          Start with 10x 5' kit adaptors
           - Patrial Read1: CTACACGACGCTCTTCCGATCT (and reverse complement)
           - Patrial Read2: AGATCGGAAGAGCACACGTCTGAA (and reverse complement)
           - TSO: TTTCTTATATGGG (and reverse complement)
           - Poly(>10)A/T
  -p, --patterns <PATTERNS_PATH>
          Start with patterns from a CSV file
          Must have the following header:
          pattern,color,editdistance,comment
  -s, --save-patterns <SAVE_PATTERNS_PATH>
          Save the search panel to a CSV file before quitting. To be removed in the future since you can now hit Ctrl-S in the search panel to save the patterns
      --quality-italic
          Enable italic styling for low quality bases (enabled by default)
      --no-quality-italic
          Disable italic styling for low quality bases
      --quality-threshold <QUALITY_THRESHOLD>
          Quality threshold for styling [default: 10]
      --quality-colors
          Enable background color styling based on quality scores. You will probably have a hard time distinguishing forground colors from background colors, so this is disabled by default
  -h, --help
          Print help
  -V, --version
          Print version
```


## seqsizzle_Enable

### Tool Description
A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
- **Homepage**: https://github.com/ChangqingW/SeqSizzle
- **Package**: https://anaconda.org/channels/bioconda/packages/seqsizzle/overview
- **Validation**: PASS

### Original Help Text
```text
A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently.

Usage: seqsizzle [OPTIONS] <FILE> [COMMAND]

Commands:
  summarize  Summarize the reads with patterns specified by the --patterns argument or the adapter flags. Make sure you supply the flags BEFORE the subcommand, e.g. `./SeqSizzle my.fastq -p my_patterns.csv --adapter-3p summarize`. '..' indicats unmatched regions of positive length, '-' indicates the patterns are overlapped, print the number of reads that match each pattern combination in TSV format. To be moved to the UI in the future
  enrich     Find enriched k-mers in the reads. This can be used to identify potential adapter/primer sequences
  help       Print this message or the help of the given subcommand(s)

Arguments:
  <FILE>  The FASTQ or FASTA file to view (supports .fastq, .fasta, .fa, .fq and their .gz variants)

Options:
      --adapter-3p
          Start with 10x 3' kit adaptors:
           - Patrial Read1: CTACACGACGCTCTTCCGATCT (and reverse complement)
           - Partial TSO: CCCATGTACTCTGCGTTGATACCA (and reverse complement)
           - Poly(>10)A/T
      --adapter-5p
          Start with 10x 5' kit adaptors
           - Patrial Read1: CTACACGACGCTCTTCCGATCT (and reverse complement)
           - Patrial Read2: AGATCGGAAGAGCACACGTCTGAA (and reverse complement)
           - TSO: TTTCTTATATGGG (and reverse complement)
           - Poly(>10)A/T
  -p, --patterns <PATTERNS_PATH>
          Start with patterns from a CSV file
          Must have the following header:
          pattern,color,editdistance,comment
  -s, --save-patterns <SAVE_PATTERNS_PATH>
          Save the search panel to a CSV file before quitting. To be removed in the future since you can now hit Ctrl-S in the search panel to save the patterns
      --quality-italic
          Enable italic styling for low quality bases (enabled by default)
      --no-quality-italic
          Disable italic styling for low quality bases
      --quality-threshold <QUALITY_THRESHOLD>
          Quality threshold for styling [default: 10]
      --quality-colors
          Enable background color styling based on quality scores. You will probably have a hard time distinguishing forground colors from background colors, so this is disabled by default
  -h, --help
          Print help
  -V, --version
          Print version
```


## seqsizzle_Disable

### Tool Description
A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
- **Homepage**: https://github.com/ChangqingW/SeqSizzle
- **Package**: https://anaconda.org/channels/bioconda/packages/seqsizzle/overview
- **Validation**: PASS

### Original Help Text
```text
A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently.

Usage: seqsizzle [OPTIONS] <FILE> [COMMAND]

Commands:
  summarize  Summarize the reads with patterns specified by the --patterns argument or the adapter flags. Make sure you supply the flags BEFORE the subcommand, e.g. `./SeqSizzle my.fastq -p my_patterns.csv --adapter-3p summarize`. '..' indicats unmatched regions of positive length, '-' indicates the patterns are overlapped, print the number of reads that match each pattern combination in TSV format. To be moved to the UI in the future
  enrich     Find enriched k-mers in the reads. This can be used to identify potential adapter/primer sequences
  help       Print this message or the help of the given subcommand(s)

Arguments:
  <FILE>  The FASTQ or FASTA file to view (supports .fastq, .fasta, .fa, .fq and their .gz variants)

Options:
      --adapter-3p
          Start with 10x 3' kit adaptors:
           - Patrial Read1: CTACACGACGCTCTTCCGATCT (and reverse complement)
           - Partial TSO: CCCATGTACTCTGCGTTGATACCA (and reverse complement)
           - Poly(>10)A/T
      --adapter-5p
          Start with 10x 5' kit adaptors
           - Patrial Read1: CTACACGACGCTCTTCCGATCT (and reverse complement)
           - Patrial Read2: AGATCGGAAGAGCACACGTCTGAA (and reverse complement)
           - TSO: TTTCTTATATGGG (and reverse complement)
           - Poly(>10)A/T
  -p, --patterns <PATTERNS_PATH>
          Start with patterns from a CSV file
          Must have the following header:
          pattern,color,editdistance,comment
  -s, --save-patterns <SAVE_PATTERNS_PATH>
          Save the search panel to a CSV file before quitting. To be removed in the future since you can now hit Ctrl-S in the search panel to save the patterns
      --quality-italic
          Enable italic styling for low quality bases (enabled by default)
      --no-quality-italic
          Disable italic styling for low quality bases
      --quality-threshold <QUALITY_THRESHOLD>
          Quality threshold for styling [default: 10]
      --quality-colors
          Enable background color styling based on quality scores. You will probably have a hard time distinguishing forground colors from background colors, so this is disabled by default
  -h, --help
          Print help
  -V, --version
          Print version
```


## seqsizzle_Print

### Tool Description
A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
- **Homepage**: https://github.com/ChangqingW/SeqSizzle
- **Package**: https://anaconda.org/channels/bioconda/packages/seqsizzle/overview
- **Validation**: PASS

### Original Help Text
```text
A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different adaptors to be colored differently.

Usage: seqsizzle [OPTIONS] <FILE> [COMMAND]

Commands:
  summarize  Summarize the reads with patterns specified by the --patterns argument or the adapter flags. Make sure you supply the flags BEFORE the subcommand, e.g. `./SeqSizzle my.fastq -p my_patterns.csv --adapter-3p summarize`. '..' indicats unmatched regions of positive length, '-' indicates the patterns are overlapped, print the number of reads that match each pattern combination in TSV format. To be moved to the UI in the future
  enrich     Find enriched k-mers in the reads. This can be used to identify potential adapter/primer sequences
  help       Print this message or the help of the given subcommand(s)

Arguments:
  <FILE>  The FASTQ or FASTA file to view (supports .fastq, .fasta, .fa, .fq and their .gz variants)

Options:
      --adapter-3p
          Start with 10x 3' kit adaptors:
           - Patrial Read1: CTACACGACGCTCTTCCGATCT (and reverse complement)
           - Partial TSO: CCCATGTACTCTGCGTTGATACCA (and reverse complement)
           - Poly(>10)A/T
      --adapter-5p
          Start with 10x 5' kit adaptors
           - Patrial Read1: CTACACGACGCTCTTCCGATCT (and reverse complement)
           - Patrial Read2: AGATCGGAAGAGCACACGTCTGAA (and reverse complement)
           - TSO: TTTCTTATATGGG (and reverse complement)
           - Poly(>10)A/T
  -p, --patterns <PATTERNS_PATH>
          Start with patterns from a CSV file
          Must have the following header:
          pattern,color,editdistance,comment
  -s, --save-patterns <SAVE_PATTERNS_PATH>
          Save the search panel to a CSV file before quitting. To be removed in the future since you can now hit Ctrl-S in the search panel to save the patterns
      --quality-italic
          Enable italic styling for low quality bases (enabled by default)
      --no-quality-italic
          Disable italic styling for low quality bases
      --quality-threshold <QUALITY_THRESHOLD>
          Quality threshold for styling [default: 10]
      --quality-colors
          Enable background color styling based on quality scores. You will probably have a hard time distinguishing forground colors from background colors, so this is disabled by default
  -h, --help
          Print help
  -V, --version
          Print version
```


## Metadata
- **Skill**: generated
