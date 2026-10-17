cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfasta
  - extract
label: pyfasta_extract
doc: "Extract some sequences from a fasta file.\n\nTool homepage: https://github.com/brentp/pyfasta"
inputs:
  - id: sequence_ids
    type:
      type: array
      items: string
    doc: "sequence identifiers (headers) to extract, or the file with them when read_from_file is set"
    inputBinding:
      position: 20
  - id: fasta
    type: File
    doc: "path to the fasta file"
    inputBinding:
      position: 1
      prefix: --fasta
      valueFrom: $(self.basename)
  - id: include_headers
    type:
      - 'null'
      - boolean
    doc: "include headers"
    inputBinding:
      position: 2
      prefix: --header
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: "extract all sequences EXCEPT those listed"
    inputBinding:
      position: 3
      prefix: --exclude
  - id: read_from_file
    type:
      - 'null'
      - boolean
    doc: "the sequences to extract are read from the file specified in args"
    inputBinding:
      position: 4
      prefix: --file
  - id: use_space_as_key
    type:
      - 'null'
      - boolean
    doc: "use the fasta identifier only up to the space as the key"
    inputBinding:
      position: 5
      prefix: --space
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
stdout: pyfasta_extract.out
