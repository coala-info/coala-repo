cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_from_fasta_with_split
label: ffindex_ffindex_from_fasta_with_split
doc: "Create two ffindex databases from a multi-FASTA file: one with the headers and\
  \ one with the sequences.\n\nTool homepage: https://github.com/soedinglab/ffindex_soedinglab"
inputs:
  - id: out_header_data_file
    type: string
    doc: Name of the output data file for the headers
    inputBinding:
      position: 1
  - id: out_header_index_file
    type: string
    doc: Name of the output index file for the headers
    inputBinding:
      position: 2
  - id: out_sequence_data_file
    type: string
    doc: Name of the output data file for the sequences
    inputBinding:
      position: 3
  - id: out_sequence_index_file
    type: string
    doc: Name of the output index file for the sequences
    inputBinding:
      position: 4
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 5
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort index file
    inputBinding:
      position: 0
      prefix: -s
outputs:
  - id: header_data_file
    type: File
    doc: ffindex data file with the headers
    outputBinding:
      glob: $(inputs.out_header_data_file)
  - id: header_index_file
    type: File
    doc: ffindex index file with the headers
    outputBinding:
      glob: $(inputs.out_header_index_file)
  - id: sequence_data_file
    type: File
    doc: ffindex data file with the sequences
    outputBinding:
      glob: $(inputs.out_sequence_data_file)
  - id: sequence_index_file
    type: File
    doc: ffindex index file with the sequences
    outputBinding:
      glob: $(inputs.out_sequence_index_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
