cwlVersion: v1.2
class: CommandLineTool
baseCommand: ganon report
label: ganon_report
doc: "Report generation from Ganon classification results.\n\nTool homepage: https://github.com/pirovc/ganon"
inputs:
  - id: db_prefix
    type:
      - 'null'
      - type: array
        items: string
    doc: Database prefix(es) used for classification. Only '.tax' file(s) are 
      required. If not provided, new taxonomy will be downloaded. Mutually 
      exclusive with --taxonomy.
    inputBinding:
      position: 101
      prefix: --db-prefix
  - id: genome_size_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Specific files for genome size estimation - otherwise files will be 
      downloaded
    inputBinding:
      position: 101
      prefix: --genome-size-files
  - id: input
    type:
      type: array
      items: File
    doc: Input file(s) and/or folder(s). '.rep' file(s) from ganon classify.
    inputBinding:
      position: 101
      prefix: --input
  - id: input_extension
    type:
      - 'null'
      - string
    doc: Required if --input contains folder(s). Wildcards/Shell Expansions not 
      supported (e.g. *).
    inputBinding:
      position: 101
      prefix: --input-extension
  - id: keep_hierarchy
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more hierarchies to keep in the report (from ganon classify 
      --hierarchy-labels)
    inputBinding:
      position: 101
      prefix: --keep-hierarchy
  - id: max_count
    type:
      - 'null'
      - float
    doc: Maximum number/percentage of counts to keep an taxa [values between 0-1
      for percentage, >1 specific number]
    inputBinding:
      position: 101
      prefix: --max-count
  - id: min_count
    type:
      - 'null'
      - float
    doc: Minimum number/percentage of counts to keep an taxa [values between 0-1
      for percentage, >1 specific number]
    inputBinding:
      position: 101
      prefix: --min-count
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: Show only entries matching exact names of the provided list
    inputBinding:
      position: 101
      prefix: --names
  - id: names_with
    type:
      - 'null'
      - type: array
        items: string
    doc: Show entries containing full or partial names of the provided list
    inputBinding:
      position: 101
      prefix: --names-with
  - id: no_orphan
    type:
      - 'null'
      - boolean
    doc: Omit orphan nodes from the final report. Otherwise, orphan nodes (= 
      nodes not found in the db/tax) are reported as 'na' with root as direct 
      parent.
    inputBinding:
      position: 101
      prefix: --no-orphan
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Ignore the number of unclassified reads, normalizing the output to 
      100%. Use with caution, can drastically change abundance estimations.
    inputBinding:
      position: 101
      prefix: --normalize
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format [text, tsv, csv, bioboxes]. text outputs a tabulated 
      formatted text file for better visualization. bioboxes is the the CAMI 
      challenge profiling format (only percentage/abundances are reported).
    inputBinding:
      position: 101
      prefix: --output-format
  - id: output_prefix
    type: string
    doc: Output prefix for report file 'output_prefix.tre'. In case of multiple 
      files, the base input filename will be appended at the end of the output 
      file 'output_prefix + FILENAME.tre'
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output mode
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: Ranks to report ['', 'all', custom list]. 'all' for all possible ranks.
      empty for default ranks [domain phylum class order family genus species 
      assembly].
    inputBinding:
      position: 101
      prefix: --ranks
  - id: report_type
    type:
      - 'null'
      - string
    doc: Type of report [abundance, reads, matches, dist, corr]. 'abundance' -> 
      tax. abundance (re-distribute read counts and correct by genome size), 
      'reads' -> sequence abundance, 'matches' -> report all unique and shared 
      matches, 'dist' -> like reads with re-distribution of shared read counts 
      only, 'corr' -> like abundance without re-distribution of shared read 
      counts
    inputBinding:
      position: 101
      prefix: --report-type
  - id: skip_genome_size
    type:
      - 'null'
      - boolean
    doc: Do not attempt to get genome sizes. Valid only without --db-prefix. 
      Activate this option when using sequences not representing full genomes.
    inputBinding:
      position: 101
      prefix: --skip-genome-size
  - id: skip_hierarchy
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more hierarchies to skip in the report (from ganon classify 
      --hierarchy-labels)
    inputBinding:
      position: 101
      prefix: --skip-hierarchy
  - id: sort
    type:
      - 'null'
      - string
    doc: 'Sort report by [rank, lineage, count, unique]. Default: rank (with custom
      --ranks) or lineage (with --ranks all)'
    inputBinding:
      position: 101
      prefix: --sort
  - id: split_hierarchy
    type:
      - 'null'
      - boolean
    doc: Split output reports by hierarchy (from ganon classify 
      --hierarchy-labels). If activated, the output files will be named as 
      '{output_prefix}.{hierarchy}.tre'
    inputBinding:
      position: 101
      prefix: --split-hierarchy
  - id: taxids
    type:
      - 'null'
      - type: array
        items: int
    doc: One or more taxids to report (including children taxa)
    inputBinding:
      position: 101
      prefix: --taxids
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: Taxonomy database to use [ncbi, gtdb, skip]. Mutually exclusive with 
      --db-prefix.
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: taxonomy_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Specific files for taxonomy - otherwise files will be downloaded
    inputBinding:
      position: 101
      prefix: --taxonomy-files
  - id: top_percentile
    type:
      - 'null'
      - float
    doc: Top percentile filter, based on percentage/relative abundance. Applied 
      only at default ranks [domain phylum class order family genus species 
      assembly]
    inputBinding:
      position: 101
      prefix: --top-percentile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output mode
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ganon:2.2.0--py312hfc6b275_0
stdout: ganon_report.out
