cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- wgatools
- maf-index
label: wgatools_maf_index
doc: 'Build index for MAF file


  Tool homepage: https://github.com/wjwei-handsome/wgatools'
inputs:
- id: input_maf
  type: File
  doc: Input MAF File
  inputBinding:
    position: 100
- id: outfile
  type:
  - 'null'
  - string
  doc: Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed
    automatically. The index is also written next to the input as <input>.index.
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
- id: maf_index
  type: File
  doc: MAF index (JSON) written next to the input MAF as <input>.index
  outputBinding:
    glob: $(inputs.input_maf.basename).index
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.input_maf)
    writable: true
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
