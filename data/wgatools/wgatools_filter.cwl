cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- wgatools
- filter
label: wgatools_filter
doc: 'Filter records for Alignment file


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
- id: min_block_size
  type:
  - 'null'
  - long
  doc: 'Min block size [default: 0]'
  inputBinding:
    position: 1
    prefix: --min-block-size
- id: min_query_size
  type:
  - 'null'
  - long
  doc: 'Min query size, usually for contigs [default: 0]'
  inputBinding:
    position: 1
    prefix: --min-query-size
- id: min_align_size
  type:
  - 'null'
  - long
  doc: Min align size for query-target pair, only for all-to-all alignment paf
  inputBinding:
    position: 1
    prefix: --min-align-size
- id: outfile
  type: string
  default: out.filtered
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
- id: output_filtered
  type: File
  doc: Filtered alignment file
  outputBinding:
    glob: $(inputs.outfile)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
