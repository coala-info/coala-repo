cwlVersion: v1.2
class: CommandLineTool
baseCommand: phynteny
label: phynteny
doc: "Phynteny predicts biosynthetic gene clusters in genomic sequences.\n\nTool homepage:
  https://github.com/susiegriggo/Phynteny"
inputs:
  - id: infile
    type: File
    doc: Input file containing genomic sequences.
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - boolean
    doc: Display help message and exit.
    inputBinding:
      position: 102
      prefix: --options
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phynteny:0.1.13--pyh7cba7a3_0
stdout: phynteny.out
