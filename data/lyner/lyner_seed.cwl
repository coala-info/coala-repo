cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - seed
label: lyner_seed
doc: "Try \"lyner seed --help\" for help.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: seed
    type: string
    doc: SEED
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_seed.out
