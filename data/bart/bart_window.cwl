cwlVersion: v1.2
class: CommandLineTool
baseCommand: window
label: bart_window
doc: "Apply Hamming (Hann) window to <input> along dimensions specified by flags\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: flags
    type: string
    doc: dimensions specified by flags
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 2
  - id: hann_window
    type:
      - 'null'
      - boolean
    doc: Hann window
    inputBinding:
      position: 103
      prefix: -H
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
