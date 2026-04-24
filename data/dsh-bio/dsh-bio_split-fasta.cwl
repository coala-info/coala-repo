cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-split-fasta
label: dsh-bio_split-fasta
doc: "Splits a FASTA file into multiple smaller files based on specified criteria.\n\
  \nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: alphabet
    type:
      - 'null'
      - string
    doc: input FASTA alphabet { dna, protein }, default dna
    inputBinding:
      position: 101
      prefix: --alphabet
  - id: bytes
    type:
      - 'null'
      - string
    doc: split input path at next record after each n bytes
    inputBinding:
      position: 101
      prefix: --bytes
  - id: input_path
    type:
      - 'null'
      - File
    doc: input FASTA path, default stdin
    inputBinding:
      position: 101
      prefix: --input-path
  - id: left_pad
    type:
      - 'null'
      - int
    doc: left pad split index in output file name
    inputBinding:
      position: 101
      prefix: --left-pad
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width, default 70
    inputBinding:
      position: 101
      prefix: --line-width
  - id: prefix
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: records
    type:
      - 'null'
      - int
    doc: split input path after each n records
    inputBinding:
      position: 101
      prefix: --records
  - id: suffix
    type:
      - 'null'
      - string
    doc: output file suffix, e.g. .fa.gz
    inputBinding:
      position: 101
      prefix: --suffix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
stdout: dsh-bio_split-fasta.out
