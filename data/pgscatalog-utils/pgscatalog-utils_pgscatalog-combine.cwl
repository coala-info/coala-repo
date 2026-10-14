cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-combine
label: pgscatalog-utils_pgscatalog-combine
doc: "Combine multiple scoring files in PGS Catalog format to a 'long' table of
  columns needed for variant matching and subsequent calculation. Custom
  scorefiles in PGS Catalog format can be combined with PGS Catalog scoring
  files, and optionally liftover genomic coordinates to GRCh37 or GRCh38. The
  script can accept a mix of unharmonised and harmonised PGS Catalog data.\n\n\
  Tool homepage: https://github.com/PGScatalog/pygscatalog"
inputs:
  - id: scorefiles
    type:
      type: array
      items: File
    doc: Scorefile paths
    inputBinding:
      position: 1
      prefix: --scorefiles
  - id: target_build
    type: string
    doc: Build of target genome (GRCh37 or GRCh38)
    inputBinding:
      position: 2
      prefix: --target_build
  - id: outfile_path
    type: string
    doc: Output path to combined long scorefile (compressed if the name ends
      with .gz)
    inputBinding:
      position: 3
      prefix: --outfile
  - id: logfile
    type:
      - 'null'
      - string
    doc: Name for the log file (score metadata) for combined scores. It is
      written beside the combined scorefile.
    inputBinding:
      position: 4
      prefix: --logfile
  - id: liftover
    type:
      - 'null'
      - boolean
    doc: Convert scoring file variants to target genome build?
    inputBinding:
      position: 5
      prefix: --liftover
  - id: chain_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory containing chain files
    inputBinding:
      position: 6
      prefix: --chain_dir
  - id: min_lift
    type:
      - 'null'
      - float
    doc: If liftover, minimum proportion of variants lifted over
    inputBinding:
      position: 7
      prefix: --min_lift
  - id: drop_missing
    type:
      - 'null'
      - boolean
    doc: Drop variants with missing information (chr/pos) and non-standard
      alleles (e.g. HLA=P/N) from the output file.
    inputBinding:
      position: 8
      prefix: --drop_missing
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Extra logging information
    inputBinding:
      position: 9
      prefix: --verbose
outputs:
  - id: outfile
    type: File
    doc: Combined long scorefile.
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: log_out
    type:
      - 'null'
      - File
    doc: Log file (score metadata) for the combined scores.
    outputBinding:
      glob: $(inputs.logfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
