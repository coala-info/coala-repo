cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapless.py
label: gapless_gapless.py
doc: "Program: gapless\nVersion: 0.4\nContact: https://github.com/schmeing/gapless\n\
  \nTool homepage: https://github.com/schmeing/gapless"
inputs:
  - id: module
    type: string
    doc: 'Module to run. Available modules: split, scaffold, extend, finish, visualize,
      test'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapless:0.4--hdfd78af_0
stdout: gapless_gapless.py.out
