cwlVersion: v1.2
class: CommandLineTool
baseCommand: wordLine
label: ucsc-wordline
doc: "Chop up words by white space and output them with one word to each line. Output
  goes to stdout.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input file(s) to process.
    inputBinding:
      position: 2
  - id: csym
    type:
      - 'null'
      - boolean
    doc: Break up words based on C symbol rules rather than white space.
    inputBinding:
      position: 1
      prefix: -csym
outputs:
  - id: words
    type: stdout
    doc: One word per line.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-wordline:482--h0b57e2e_0
stdout: ucsc-wordline.out
