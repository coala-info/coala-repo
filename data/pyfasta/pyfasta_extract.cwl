cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfasta_extract
label: pyfasta_extract
doc: "Extract some sequences from a fasta file.\n\nTool homepage: https://github.com/brentp/pyfasta"
inputs:
  - id: sequence_ids
    type:
      type: array
      items: string
    doc: Sequence IDs to extract
    inputBinding:
      position: 1
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: extract all sequences EXCEPT those listed
    inputBinding:
      position: 102
      prefix: --exclude
  - id: fasta_file
    type: File
    doc: path to the fasta file
    inputBinding:
      position: 102
      prefix: --fasta
  - id: include_headers
    type:
      - 'null'
      - boolean
    doc: include headers
    inputBinding:
      position: 102
      prefix: --header
  - id: read_from_file
    type:
      - 'null'
      - boolean
    doc: if this flag is used, the sequences to extract are read from the file 
      specified in args
    inputBinding:
      position: 102
      prefix: --file
  - id: use_space_as_key
    type:
      - 'null'
      - boolean
    doc: use the fasta identifier only up to the space as the key
    inputBinding:
      position: 102
      prefix: --space
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
stdout: pyfasta_extract.out
