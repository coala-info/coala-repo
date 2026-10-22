# swga CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| swga_activate | PASS |  |
| swga_count | PASS |  |
| swga_export | PASS |  |
| swga_filter | PASS |  |
| swga_find_sets | PASS |  |
| swga_init | PASS |  |
| swga_score | PASS |  |
| swga_summary | PASS | ran on a populated workspace; it reports 70152 primers, 42 active and 51 sets, matching the database |

## swga_init

### Tool Description
Initialize the current directory as an swga workspace.

### Metadata
- **Docker Image**: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
- **Homepage**: https://github.com/eclarke/swga
- **Package**: https://anaconda.org/channels/bioconda/packages/swga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/swga/overview
- **Total Downloads**: 18.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/eclarke/swga
- **Stars**: N/A
### Original Help Text
```text
usage: swga [-h] [-f FG_GENOME_FP] [-b BG_GENOME_FP] [-e EXCLUDE_FP] [--force]

Initialize the current directory as an swga workspace.

optional arguments:
  -h, --help            show this help message and exit
  -f FG_GENOME_FP, --fg_genome_fp FG_GENOME_FP
                        Path to foreground genome/sequences (in FASTA format)
  -b BG_GENOME_FP, --bg_genome_fp BG_GENOME_FP
                        Path to background genome/sequences (in FASTA format)
  -e EXCLUDE_FP, --exclude_fp EXCLUDE_FP
                        Path to sequences to exclude from analysis (in FASTA
                        format)
  --force               Overwrite any existing data in the directory without
                        prompts
```

## swga_count

### Tool Description
Count k-mers in a foreground genome, then in a background genome, and add the results to the database

### Metadata
- **Docker Image**: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
- **Homepage**: https://github.com/eclarke/swga
- **Package**: https://anaconda.org/channels/bioconda/packages/swga/overview
- **Validation**: PASS

### Original Help Text
```text
usage: count [-h] [--min_size MIN_SIZE] [--max_size MAX_SIZE]
             [--min_fg_bind MIN_FG_BIND] [--max_bg_bind MAX_BG_BIND]
             [--max_dimer_bp MAX_DIMER_BP]
             [--exclude_threshold EXCLUDE_THRESHOLD] [--input INPUT] [--force]

Count kmers in a foreground genome, then count those in a background genome,
and add results to database

optional arguments:
  -h, --help            show this help message and exit
  --min_size MIN_SIZE   minimum kmer size
  --max_size MAX_SIZE   maximum kmer size
  --min_fg_bind MIN_FG_BIND
                        minimum number of primer binding sites on fg genome
                        (default autofilled using genome length and binding
                        rate of 1/100000)
  --max_bg_bind MAX_BG_BIND
                        maximum primer binding sites on bg genome (default
                        autofilled using genome length and binding rate of
                        1/150000)
  --max_dimer_bp MAX_DIMER_BP
                        max number of consecutive complementary bases between
                        a primer and its rev. complement
  --exclude_threshold EXCLUDE_THRESHOLD
                        primers appearing >= this in exclude_fp will be
                        excluded
  --input INPUT         a list of primers to manually add to the database
  --force               clear any previous primers without prompting
```

## swga_filter

### Tool Description
Activate suitable primers in a database

### Metadata
- **Docker Image**: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
- **Homepage**: https://github.com/eclarke/swga
- **Package**: https://anaconda.org/channels/bioconda/packages/swga/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter [-h] [--input INPUT] [--skip_filtering]
              [--max_primers MAX_PRIMERS] [--min_fg_bind MIN_FG_BIND]
              [--max_bg_bind MAX_BG_BIND] [--min_tm MIN_TM] [--max_tm MAX_TM]
              [--max_gini MAX_GINI]

Activate suitable primers in a database

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         List of primers (one per line) to activate, instead of
                        pulling from db
  --skip_filtering      Skip filtering and simply mark the provided primers
                        from --input as active
  --max_primers MAX_PRIMERS
                        max number of primers to keep after filtering
  --min_fg_bind MIN_FG_BIND
                        minimum number of primer binding sites on fg genome
                        (default autofilled using genome length and binding
                        rate of 1/100000)
  --max_bg_bind MAX_BG_BIND
                        maximum primer binding sites on bg genome (default
                        autofilled using genome length and binding rate of
                        1/150000)
  --min_tm MIN_TM       minimum primer melting temperature (C)
  --max_tm MAX_TM       maximum primer melting temperature (C)
  --max_gini MAX_GINI   maximum Gini coefficient for an individual primer on
                        the foreground genome
```

## swga_find_sets

### Tool Description
Find sets of compatible primers in a primer compatibility graph

### Metadata
- **Docker Image**: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
- **Homepage**: https://github.com/eclarke/swga
- **Package**: https://anaconda.org/channels/bioconda/packages/swga/overview
- **Validation**: PASS

### Original Help Text
```text
usage: find_sets [-h] [--min_size MIN_SIZE] [--max_size MAX_SIZE]
                 [--max_dimer_bp MAX_DIMER_BP]
                 [--min_bg_bind_dist MIN_BG_BIND_DIST]
                 [--max_fg_bind_dist MAX_FG_BIND_DIST] [--max_sets MAX_SETS]
                 [--reset] [--workers WORKERS] [--force]
                 [--score_expression SCORE_EXPRESSION]

Find sets of compatible primers in a primer compatibility graph

optional arguments:
  -h, --help            show this help message and exit
  --min_size MIN_SIZE   minimum size of primer sets
  --max_size MAX_SIZE   max size of primer sets
  --max_dimer_bp MAX_DIMER_BP
                        max number of consecutive complimentary bases between
                        two primers
  --min_bg_bind_dist MIN_BG_BIND_DIST
                        min avg distance between primers in the bg genome
  --max_fg_bind_dist MAX_FG_BIND_DIST
                        Max distance between primers on the foreground genome
  --max_sets MAX_SETS   Max number of sets to check (if < 0, will find as many
                        sets as possible)
  --reset               remove all previously-found sets
  --workers WORKERS     number of workers to spawn. 1 worker searches graph
                        using weighted vertex coloring; > 1 workers randomizes
                        vertex coloring to explore more area simultaneously.
  --force               clear any previous sets without prompting
  --score_expression SCORE_EXPRESSION
                        Specify an expression to calculate the set score. Code
                        must only use the following variables: set_size,
                        fg_dist_mean, fg_dist_std, fg_dist_gini, fg_dist_max,
                        bg_dist_mean. Expression must have valid Python
                        syntax.
```

## swga_export

### Tool Description
Retrieve or export primers or sets from the database

### Metadata
- **Docker Image**: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
- **Homepage**: https://github.com/eclarke/swga
- **Package**: https://anaconda.org/channels/bioconda/packages/swga/overview
- **Validation**: PASS

### Original Help Text
```text
usage: export [-h] [--output OUTPUT] [--order_by ORDER_BY] [--descending]
              [--limit LIMIT] [--ids [IDS [IDS ...]]] [--no_header]
              [--opts_str OPTS_STR] [--window_size WINDOW_SIZE]
              [--step_size STEP_SIZE] [--output_folder OUTPUT_FOLDER]
              {set,sets,primer,primers,bedfile,bedgraph,lorenz}

retrieve or export primers or sets from the database

positional arguments:
  {set,sets,primer,primers,bedfile,bedgraph,lorenz}
                        what to export (sets, primers, bedfile, bedgraph)

optional arguments:
  -h, --help            show this help message and exit
  --output OUTPUT       where to write results
  --order_by ORDER_BY   order the results (before any limits imposed)
  --descending          return in descending order if --order_by specified
  --limit LIMIT         max results to display, at max (values less than zero
                        mean no limit)
  --ids [IDS [IDS ...]]
                        the ids of the sets or primers to use
  --no_header           don't display header
  --opts_str OPTS_STR   (bedgraph export only) the options string to add to
                        the track line
  --window_size WINDOW_SIZE
                        (bedgraph export only) the size of the sliding window
                        used to calculate avg primer binding
  --step_size STEP_SIZE
                        (bedgraph export only) the step size used to move the
                        sliding window (default: window_size/5)
  --output_folder OUTPUT_FOLDER
                        (bed* export only) the folder to store the bedgraph or
                        bedfiles
```

## swga_activate

### Tool Description
Activate a list of primers, updating melting temperature and foreground binding locations as needed

### Metadata
- **Docker Image**: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
- **Homepage**: https://github.com/eclarke/swga
- **Package**: https://anaconda.org/channels/bioconda/packages/swga/overview
- **Validation**: PASS

### Original Help Text
```text
usage: activate [-h] [--reset] input

activate a list of primers, updating melting temp and fg binding locations as
needed

positional arguments:
  input       a file containing a list of primers to score, one per line

optional arguments:
  -h, --help  show this help message and exit
  --reset     reset what primers are marked as active
```

## swga_score

### Tool Description
Score a set of primers

### Metadata
- **Docker Image**: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
- **Homepage**: https://github.com/eclarke/swga
- **Package**: https://anaconda.org/channels/bioconda/packages/swga/overview
- **Validation**: PASS

### Original Help Text
```text
usage: score [-h] [--input INPUT] [--force]
             [--score_expression SCORE_EXPRESSION]

score a set of primers

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         a file containing a list of primers to score, one per
                        line
  --force               do not prompt for confirmation before adding a set
                        manually
  --score_expression SCORE_EXPRESSION
                        Specify an expression to calculate the set score. Code
                        must only use the following variables: set_size,
                        fg_dist_mean, fg_dist_std, fg_dist_gini, fg_dist_max,
                        bg_dist_mean. Expression must have valid Python
                        syntax.
```

## swga_summary

### Tool Description
Print a summary of the primers and sets found so far

### Metadata
- **Docker Image**: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
- **Homepage**: https://github.com/eclarke/swga
- **Package**: https://anaconda.org/channels/bioconda/packages/swga/overview
- **Validation**: PASS

### Original Help Text
```text
usage: summary [-h]

Print a summary of the primers and sets found so far.

optional arguments:
  -h, --help  show this help message and exit
```

