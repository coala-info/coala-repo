cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dsh-bio
  - extract-fasta
label: dsh-bio_extract-fasta
doc: "extract matching DNA or protein sequences in FASTA format\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta_path
    type: File
    doc: "input FASTA path, default stdin"
    inputBinding:
      position: 101
      prefix: --input-fasta-path
  - id: output_fasta_file_path
    type: string
    doc: "output FASTA file, default stdout"
    inputBinding:
      position: 101
      prefix: --output-fasta-file
  - id: name
    type:
      - 'null'
      - string
    doc: "exact sequence name to match"
    inputBinding:
      position: 101
      prefix: --name
  - id: description
    type:
      - 'null'
      - string
    doc: "FASTA description line regex pattern to match"
    inputBinding:
      position: 101
      prefix: --description
  - id: alphabet
    type:
      - 'null'
      - string
    doc: "input FASTA alphabet { dna, protein }, default dna"
    inputBinding:
      position: 101
      prefix: --alphabet
  - id: line_width
    type:
      - 'null'
      - int
    doc: "line width, default 70"
    inputBinding:
      position: 101
      prefix: --line-width
outputs:
  - id: output_fasta_file
    type:
      - 'null'
      - File
    doc: "output FASTA file, default stdout"
    outputBinding:
      glob: $(inputs.output_fasta_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
