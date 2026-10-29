cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- wgatools
- dotplot
label: wgatools_dotplot
doc: 'Plot dotplot for Alignment file


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
- id: out_format
  type:
  - 'null'
  - type: enum
    symbols:
    - html
    - json
    - csv
  doc: 'Output format [default: html] [possible values: html, json, csv]'
  inputBinding:
    position: 1
    prefix: --out-format
- id: mode
  type:
  - 'null'
  - type: enum
    symbols:
    - base-level
    - overview
  doc: 'Plot mode, BaseLevel or Overview [default: base-level] [possible values: base-level,
    overview]'
  inputBinding:
    position: 1
    prefix: --mode
- id: no_identity
  type:
  - 'null'
  - boolean
  doc: 'do not show identity in Overview mode, default: false'
  inputBinding:
    position: 1
    prefix: --no-identity
- id: length
  type:
  - 'null'
  - long
  doc: 'Skip segment with length less than cutoff in BaseLevel mode, default: 0'
  inputBinding:
    position: 1
    prefix: --length
- id: query_name
  type:
  - 'null'
  - string
  doc: Query name when multiple query in MAF, None for first query
  inputBinding:
    position: 1
    prefix: --query-name
- id: color
  type:
  - 'null'
  - string
  doc: Custom colors for CIGAR types in format "M:#FF0000,I:#00FF00,D:#0000FF,MR:#111111"
  inputBinding:
    position: 1
    prefix: --color
- id: outfile
  type: string
  default: out.html
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
- id: output_plot
  type: File
  doc: Dotplot file (html, json or csv, as set by out_format)
  outputBinding:
    glob: $(inputs.outfile)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
