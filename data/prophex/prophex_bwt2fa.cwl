cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophex
  - bwt2fa
label: prophex_bwt2fa
doc: "Convert BWT index to FASTA format\n\nTool homepage: https://github.com/prophyle/prophex"
inputs:
  - id: idxbase
    type: File
    doc: Reference FASTA file with its prophex/bwa index files
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
    inputBinding:
      position: 1
  - id: output_fa_path
    type: string
    doc: Output FASTA file name
    inputBinding:
      position: 2
outputs:
  - id: output_fa
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output_fa_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
