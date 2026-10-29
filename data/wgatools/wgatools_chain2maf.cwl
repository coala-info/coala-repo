cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- wgatools
- chain2maf
label: wgatools_chain2maf
doc: 'Convert Chain format to MAF format


  Tool homepage: https://github.com/wjwei-handsome/wgatools'
inputs:
- id: input_chain
  type: File
  doc: Input Chain File, None for STDIN
  inputBinding:
    position: 100
- id: target
  type: File
  doc: Input target FASTA File, required
  inputBinding:
    position: 1
    prefix: --target
- id: query
  type: File
  doc: Input query FASTA File, required
  inputBinding:
    position: 1
    prefix: --query
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
  doc: MAF alignment file
  outputBinding:
    glob: $(inputs.outfile)
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.target)
    writable: true
  - entry: $(inputs.query)
    writable: true
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
