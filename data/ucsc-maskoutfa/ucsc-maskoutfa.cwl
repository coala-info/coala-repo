cwlVersion: v1.2
class: CommandLineTool
baseCommand: maskOutFa
label: ucsc-maskoutfa
doc: "Mask out regions of a FASTA file based on coordinates provided in a BED or RepeatMasker
  .out file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file to be masked
    inputBinding:
      position: 1
  - id: mask_file
    type: File
    doc: File containing coordinates to mask (typically a .bed or RepeatMasker .out
      file)
    inputBinding:
      position: 2
outputs:
  - id: output_fasta
    type: File
    doc: Output masked FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maskoutfa:482--h0b57e2e_0
