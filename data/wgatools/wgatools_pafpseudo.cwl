cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- wgatools
- pafpseudo
label: wgatools_pafpseudo
doc: 'Generate pesudo-maf for divergence analysis from PAF file


  Tool homepage: https://github.com/wjwei-handsome/wgatools'
inputs:
- id: input_paf
  type: File
  doc: Input PAF File, None for STDIN
  inputBinding:
    position: 100
- id: fasta
  type:
  - 'null'
  - File
  doc: Input FASTA File with index(support .gz), if None, just output `N`,`1`,`0`,`-`
  secondaryFiles:
  - pattern: .fai
    required: true
  inputBinding:
    position: 1
    prefix: --fasta
- id: target
  type:
  - 'null'
  - string
  doc: select target for output
  inputBinding:
    position: 1
    prefix: --target
- id: outfile
  type: string
  default: pseudo_maf
  doc: 'Output folder: the tool writes one <target>.maf file per target sequence into
    it. Written to the working directory.'
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
- id: output_dir
  type: Directory
  doc: Folder with one pseudo-MAF file per target
  outputBinding:
    glob: $(inputs.outfile)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
