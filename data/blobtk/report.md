# blobtk CWL Generation Report

## blobtk_depth

### Tool Description
Calculate sequencing coverage depth.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
- **Homepage**: https://github.com/genomehubs/blobtk
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blobtk/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-06-24
- **GitHub**: https://github.com/genomehubs/blobtk
- **Stars**: N/A
### Original Help Text
```text
Calculate sequencing coverage depth. Called as `blobtk depth`

Usage: blobtk depth [OPTIONS]

Options:
  -i, --list <TXT>           Path to input file containing a list of sequence IDs
  -b, --bam <BAM>            Path to BAM file
  -c, --cram <CRAM>          Path to CRAM file
  -a, --fasta <FASTA>        Path to assembly FASTA input file (required for CRAM)
  -s, --bin-size <BIN_SIZE>  Bin size for coverage calculations (use 0 for full contig length) [default: 0]
  -O, --bed <BED>            Output bed file name
  -h, --help                 Print help
```


## blobtk_filter

### Tool Description
Filter files based on list of sequence names.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
- **Homepage**: https://github.com/genomehubs/blobtk
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtk/overview
- **Validation**: PASS

### Original Help Text
```text
Filter files based on list of sequence names. Called as `blobtk filter`

Usage: blobtk filter [OPTIONS]

Options:
  -i, --list <TXT>       Path to input file containing a list of sequence IDs
  -b, --bam <BAM>        Path to BAM file
  -c, --cram <CRAM>      Path to CRAM file
  -a, --fasta <FASTA>    Path to assembly FASTA input file (required for CRAM)
  -f, --fastq <FASTQ>    Path to FASTQ file to filter (forward or single reads)
  -r, --fastq2 <FASTQ>   Path to paired FASTQ file to filter (reverse reads)
  -S, --suffix <SUFFIX>  Suffix to use for output filtered files [default: filtered]
  -A, --fasta-out        Flag to output a filtered FASTA file
  -F, --fastq-out        Flag to output filtered FASTQ files
  -O, --read-list <TXT>  Path to output list of read IDs
  -h, --help             Print help
```


## blobtk_index

### Tool Description
Index files for GenomeHubs. Called as `blobtk index`

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
- **Homepage**: https://github.com/genomehubs/blobtk
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtk/overview
- **Validation**: PASS

### Original Help Text
```text
[experimental] Index files for GenomeHubs. Called as `blobtk index`

Usage: blobtk index [OPTIONS]

Options:
  -b, --blobdir <BLOBDIR>               Path to BlobDir directory containing files to index
  -w, --window-size <WINDOW_SIZE>...    Window sizes for feature extraction. Supported values depend on the BlobDir (typically 0.01, 0.1, 1, 100000, 1000000) [default: 1]
  -t, --taxon-id <TAXON_ID>             Taxon ID for the assembly
  -a, --accession <DATASETS_ACCESSION>  Assembly accession to fetch sequence report from NCBI datasets
  -u, --busco <BUSCO>...                Path to BUSCO directory containing files to index Multiple BUSCO directories can be provided
  -g, --schema                          Flag to generate JSON schema
  -O, --out <OUT>                       Output schema file name
  -h, --help                            Print help
```


## blobtk_plot

### Tool Description
Process a BlobDir and produce static plots.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
- **Homepage**: https://github.com/genomehubs/blobtk
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtk/overview
- **Validation**: PASS

### Original Help Text
```text
Process a BlobDir and produce static plots. Called as `blobtk plot`

Usage: blobtk plot [OPTIONS] --blobdir <BLOBDIR> --view <VIEW>

Options:
  -d, --blobdir <BLOBDIR>
          Path to BlobDir directory
  -v, --view <VIEW>
          View to plot [possible values: blob, cumulative, legend, snail]
      --shape <SHAPE>
          Plot shape for blob plot [possible values: circle, grid]
  -w, --window-size <WINDOW_SIZE>
          Window size for grid shape plot
  -o, --output <OUTPUT>
          Output filename [default: output.svg]
  -f, --filter <FILTER>
          
  -s, --segments <SEGMENTS>
          Segment count for snail plot [default: 1000]
      --max-span <MAX_SPAN>
          Max span for snail plot
      --max-scaffold <MAX_SCAFFOLD>
          max scaffold length for snail plot
  -x, --x-field <X_FIELD>
          X-axis field for blob plot
  -y, --y-field <Y_FIELD>
          Y-axis field for blob plot
  -z, --z-field <Z_FIELD>
          Z-axis field for blob plot
  -c, --category <CAT_FIELD>
          Category field for blob plot
      --synonyms <SYNONYM_FIELD>
          Field to use for sequence identifier synonyms
      --resolution <RESOLUTION>
          Resolution for blob plot [default: 30]
      --hist-height <HIST_HEIGHT>
          Maximum histogram height for blob plot
      --reducer-function <REDUCER_FUNCTION>
          Reducer function for blob plot [default: sum] [possible values: sum, max, min, count, mean]
      --scale-function <SCALE_FUNCTION>
          Scale function for blob/snail plot [default: sqrt] [possible values: linear, sqrt, log]
      --scale-factor <SCALE_FACTOR>
          Scale factor for blob plot (0.2 - 5.0) [default: 1]
      --x-limit <X_LIMIT>
          X-axis limits for blob/cumulative plot (<min>,<max>)
      --y-limit <Y_LIMIT>
          Y-axis limits for blob/cumulative plot (<min>,<max>)
      --cat-count <CAT_COUNT>
          Maximum number of categories for blob/cumulative plot [default: 10]
      --legend <SHOW_LEGEND>
          Maximum number of categories for blob/cumulative plot [default: default] [possible values: default, full, compact, none]
      --cat-order <CAT_ORDER>
          Category order for blob/cumulative plot (<cat1>,<cat2>,...)
      --origin <ORIGIN>
          Origin for category lines in cumulative plot [possible values: o, x, y]
      --palette <PALETTE>
          Colour palette for categories [possible values: default, inverse, viridis]
      --color <COLOR>
          Individual colours to modify palette (<index>=<hexcode>)
      --significant-digits <SIGNIFICANT_DIGITS>
          [experimental] Significant digits to use when rounding numbers for display [default: 3]
      --decimal-precision <DECIMAL_PRECISION>
          [experimental] Decimal precision (number of decimal places) to use when percentages for display [default: 2]
      --rounding <ROUNDING>
          [possible values: round, down, up]
      --show-numbers
          [experimental] Flag to show numbers instead of percentages in snail plot legend
      --busco-numbers
          [experimental] Flag to show busco numbers instead of percentages in snail plot legend
  -h, --help
          Print help
```


## blobtk_taxonomy

### Tool Description
Process a taxonomy and lookup lineages, or start the API server with --api

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
- **Homepage**: https://github.com/genomehubs/blobtk
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtk/overview
- **Validation**: PASS

### Original Help Text
```text
[experimental] Process a taxonomy and lookup lineages, or start the API server with --api Called as `blobtk taxonomy [--api] ...`

Usage: blobtk taxonomy [OPTIONS]

Options:
  -t, --taxdump <PATH>
          Path to backbone taxonomy file/directory

  -f, --taxonomy-format <TAXONOMY_FORMAT>
          Format of taxonomy file

          Possible values:
          - ncbi:        NCBI taxdump containing nodes.dmp, names.dmp and merged.dmp
          - gbif:        GBIF simple format backbone taxonomy
          - ena:         ENA taxonomy record formatted as JSONL
          - ott:         OTT (Open Tree of Life) taxonomy containing taxonomy.tsv, synonyms.tsv and forwards.tsv
          - genome-hubs: GenomeHubs TSV/YAML file pair

  -r, --root-id <ROOT_TAXON_ID>
          Root taxon/taxa for filtered taxonomy

  -l, --leaf-id <LEAF_TAXON_ID>
          Leaf taxon/taxa for filtered taxonomy

  -b, --base-id <BASE_TAXON_ID>
          Base taxon for filtered taxonomy lineages

  -O, --taxdump-out <OUT>
          Path to output filtered backbone taxonomy

  -c, --config <CONFIG_FILE>
          Path to YAML format config file

  -x, --xref-label <XREF_LABEL>
          Label to use when setting as xref

  -g, --genomehubs_files <GENOMEHUBS_FILES>
          Files to match to taxIDs - Experimental

      --api
          [experimental] Start the taxonomy API server instead of running a one-off merge/output

  -p, --port <PORT>
          Port to run the API server on (if --api is set)
          
          [default: 3000]

  -h, --help
          Print help (see a summary with '-h')
```


## blobtk_validate

### Tool Description
Validate BlobToolKit and GenomeHubs files.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
- **Homepage**: https://github.com/genomehubs/blobtk
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtk/overview
- **Validation**: PASS

### Original Help Text
```text
[experimental] Validate BlobToolKit and GenomeHubs files. Called as `blobtk validate`

Usage: blobtk validate [OPTIONS]

Options:
  -t, --taxdump <TAXDUMP>
          Path to backbone taxonomy file/directory

  -f, --taxonomy-format <TAXONOMY_FORMAT>
          Format of taxonomy file

          Possible values:
          - ncbi:        NCBI taxdump containing nodes.dmp, names.dmp and merged.dmp
          - gbif:        GBIF simple format backbone taxonomy
          - ena:         ENA taxonomy record formatted as JSONL
          - ott:         OTT (Open Tree of Life) taxonomy containing taxonomy.tsv, synonyms.tsv and forwards.tsv
          - genome-hubs: GenomeHubs TSV/YAML file pair

  -n, --name-classes <NAME_CLASSES>
          List of name_classes to use during taxon lookup
          
          [default: "scientific name"]

  -g, --genomehubs_files <GENOMEHUBS_FILES>
          Files to match to taxIDs - Experimental

  -S, --schema <SCHEMA>
          Path to output JSON Schema file

  -d, --dry-run
          

  -k, --skip-tsv
          

  -h, --help
          Print help (see a summary with '-h')
```

