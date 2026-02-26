cwlVersion: v1.2
class: CommandLineTool
baseCommand: faSomeRecords
label: ucsc-fasomerecords_faSomeRecords
doc: "Extract multiple fa records\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: list_file
    type: File
    doc: File containing a list of records to extract
    inputBinding:
      position: 2
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: output sequences not in the list file.
    inputBinding:
      position: 103
      prefix: -exclude
outputs:
  - id: output_fa
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fasomerecords:482--h0b57e2e_0
