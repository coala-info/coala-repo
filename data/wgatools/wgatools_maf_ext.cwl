cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- wgatools
- maf-ext
label: wgatools_maf_ext
doc: 'Extract specific region from MAF file with index


  Tool homepage: https://github.com/wjwei-handsome/wgatools'
inputs:
- id: input_maf
  type: File
  doc: Input MAF File, None for STDIN. Needs its index <input>.index (made by maf-index)
    beside it.
  secondaryFiles:
  - pattern: .index
    required: true
  inputBinding:
    position: 100
- id: regions
  type:
  - 'null'
  - string
  doc: Input regions
  inputBinding:
    position: 1
    prefix: --regions
- id: regions_file
  type:
  - 'null'
  - File
  doc: Input regions file
  inputBinding:
    position: 1
    prefix: --file
- id: outfile
  type: string
  default: out.maf
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
- id: output_maf
  type: File
  doc: MAF file with the extracted regions
  outputBinding:
    glob: $(inputs.outfile)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
