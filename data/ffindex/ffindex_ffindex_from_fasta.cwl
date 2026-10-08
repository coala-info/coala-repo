cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_from_fasta
label: ffindex_ffindex_from_fasta
doc: "Create an ffindex with one entry per sequence of a multi-FASTA file.\n\nTool\
  \ homepage: https://github.com/soedinglab/ffindex_soedinglab"
inputs:
  - id: out_data_file
    type: string
    doc: Name of the output ffindex data file
    inputBinding:
      position: 1
  - id: out_index_file
    type: string
    doc: Name of the output ffindex index file
    inputBinding:
      position: 2
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 3
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort index file
    inputBinding:
      position: 0
      prefix: -s
outputs:
  - id: data_file
    type: File
    doc: ffindex data file
    outputBinding:
      glob: $(inputs.out_data_file)
  - id: index_file
    type: File
    doc: ffindex index file
    outputBinding:
      glob: $(inputs.out_index_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
