cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophex
  - bwt2fa
label: prophex_bwt2fa
doc: "Convert BWT index to FASTA format\n\nTool homepage: https://github.com/prophyle/prophex"
inputs:
  - id: idxbase
    type: string
    doc: Base name of the BWT index files
    inputBinding:
      position: 1
outputs:
  - id: output_fa
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
