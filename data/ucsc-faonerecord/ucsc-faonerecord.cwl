cwlVersion: v1.2
class: CommandLineTool
baseCommand: faOneRecord
label: ucsc-faonerecord
doc: "Extract a single record from a FASTA file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: The input FASTA file.
    inputBinding:
      position: 1
  - id: record_name
    type: string
    doc: The name of the record to extract.
    inputBinding:
      position: 2
outputs:
  - id: output_fasta
    type: File
    doc: The output FASTA file containing the single record.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-faonerecord:482--h0b57e2e_0
