cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- wgatools
- pafcov
label: wgatools_pafcov
doc: 'Calculate coverage for PAF file


  Tool homepage: https://github.com/wjwei-handsome/wgatools'
inputs:
- id: input_paf
  type: File
  doc: Input PAF File, None for STDIN
  inputBinding:
    position: 100
- id: outfile
  type: string
  default: out.cov.tsv
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
- id: output_coverage
  type: File
  doc: Per-base coverage table
  outputBinding:
    glob: $(inputs.outfile)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
