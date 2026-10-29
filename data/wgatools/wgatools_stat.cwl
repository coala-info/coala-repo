cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- wgatools
- stat
label: wgatools_stat
doc: 'Statistics for Alignment file


  Tool homepage: https://github.com/wjwei-handsome/wgatools'
inputs:
- id: input_alignment
  type: File
  doc: Input Alignment File, None for STDIN
  inputBinding:
    position: 100
- id: format
  type:
  - 'null'
  - type: enum
    symbols:
    - maf
    - paf
    - chain
  doc: 'Input File format, [default: maf] [possible values: maf, paf, chain]'
  inputBinding:
    position: 1
    prefix: --format
- id: each
  type:
  - 'null'
  - boolean
  doc: 'Show each block''s statistics, default: false'
  inputBinding:
    position: 1
    prefix: --each
- id: query_name
  type:
  - 'null'
  - string
  doc: Query name when multiple query in MAF, None for first query
  inputBinding:
    position: 1
    prefix: --query-name
- id: outfile
  type: string
  default: out.stat.tsv
  doc: Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed
    automatically. Written to the working directory.
  inputBinding:
    position: 101
    prefix: --outfile
- id: rewrite
  type:
  - 'null'
  - boolean
  doc: Bool, if rewrite output file
  inputBinding:
    position: 102
    prefix: --rewrite
- id: threads
  type:
  - 'null'
  - int
  doc: Threads, default 1
  inputBinding:
    position: 103
    prefix: --threads
- id: verbose
  type:
  - 'null'
  - boolean
  doc: 'Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]'
  inputBinding:
    position: 104
    prefix: --verbose
outputs:
- id: output_stat
  type: File
  doc: Tab-separated alignment statistics
  outputBinding:
    glob: $(inputs.outfile)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
