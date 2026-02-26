cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-format
label: pgscatalog.core_pgscatalog-format
doc: "Format multiple scoring files in PGS Catalog format (see https://www.pgscatalog.org/downloads/
  for details) to a standard column set needed for variant matching and subsequent
  calculation. During this process Variants are checked to make sure they pass data
  validation using the PGS Catalog standard data models. Custom scorefiles in PGS
  Catalog format can be combined with PGS Catalog scoring files, and optionally liftover
  genomic coordinates to GRCh37 or GRCh38. The script can accept a mix of unharmonised
  and harmonised PGS Catalog data. By default all variants are output (including positions
  with duplicated data [often caused by rsID/liftover collions across builds]) and
  variants with missing positions.\n\nTool homepage: https://github.com/PGScatalog/pygscatalog/"
inputs:
  - id: scorefiles
    type:
      type: array
      items: File
    doc: Scorefile paths
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of records to process in each batch
    inputBinding:
      position: 102
      prefix: --batch_size
  - id: chain_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory containing chain files
    inputBinding:
      position: 102
      prefix: --chain_dir
  - id: drop_missing
    type:
      - 'null'
      - boolean
    doc: Drop variants with missing information (chr/pos) and non-standard 
      alleles (e.g. HLA=P/N) from the output file.
    inputBinding:
      position: 102
      prefix: --drop_missing
  - id: liftover
    type:
      - 'null'
      - boolean
    doc: Convert scoring file variants to target genome build?
    inputBinding:
      position: 102
      prefix: --liftover
  - id: logfile
    type: File
    doc: Name for the log file (score metadata) for combined scores.[ will write
      to identical directory as combined scorefile]
    inputBinding:
      position: 102
      prefix: --logfile
  - id: min_lift
    type:
      - 'null'
      - float
    doc: If liftover, minimum proportion of variants lifted over
    inputBinding:
      position: 102
      prefix: --min_lift
  - id: target_build
    type: string
    doc: Build of target genome
    inputBinding:
      position: 102
      prefix: --target_build
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of Python worker processes to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Extra logging information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type: File
    doc: Output path to combined long scorefile [ will compress output if 
      filename ends with .gz ]
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.core:1.0.2--pyhdfd78af_0
