cwlVersion: v1.2
class: CommandLineTool
baseCommand: tagore
label: tagore
doc: "a utility for illustrating human chromosomes https://github.com/jordanlab/tagore\n\
  \nTool homepage: https://github.com/jordanlab/tagore"
inputs:
  - id: build
    type:
      - 'null'
      - string
    doc: Human genome build to use
    inputBinding:
      position: 101
      prefix: --build
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output files if they exist already
    inputBinding:
      position: 101
      prefix: --force
  - id: input_bed
    type: File
    doc: Input BED-like file
    inputBinding:
      position: 101
      prefix: --input
  - id: oformat
    type:
      - 'null'
      - string
    doc: Output format for conversion (pdf requires rsvg-convert)
    inputBinding:
      position: 101
      prefix: --oformat
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tagore:1.1.2--pyhdfd78af_0
stdout: tagore.out
