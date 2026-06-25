cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - build_biscuit_QC_assets.pl
label: biscuit_build_biscuit_QC_assets.pl
doc: "Build biscuit QC assets from a reference genome.\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: include_all
    type:
      - 'null'
      - boolean
    doc: include all chromosomes/contigs. Default is to restrict to 
      chr[0-9]*,chrX,chrY,chrM
    inputBinding:
      position: 101
      prefix: --include
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: reference input genome in FASTA format
    inputBinding:
      position: 101
      prefix: --ref
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print additional messages
    inputBinding:
      position: 101
      prefix: --verbose
  - id: outdir_path
    type: string
    doc: Output or path parameter `outdir_path`
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type: Directory
    doc: directory to put the 3 output biscuit QC asset files
    outputBinding:
      glob: $(inputs.outdir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
