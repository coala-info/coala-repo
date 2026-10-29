cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- wgatools
- paf2chain
label: wgatools_paf2chain
doc: 'Convert PAF format to Chain format


  Tool homepage: https://github.com/wjwei-handsome/wgatools'
inputs:
- id: input_paf
  type: File
  doc: Input PAF File, None for STDIN
  inputBinding:
    position: 100
- id: outfile
  type: string
  default: out.chain
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
- id: output_chain
  type: File
  doc: Chain alignment file
  outputBinding:
    glob: $(inputs.outfile)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
