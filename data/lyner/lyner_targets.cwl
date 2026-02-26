cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - targets
label: lyner_targets
doc: "Specify targets for lyner\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: targets
    type:
      type: array
      items: string
    doc: Targets for lyner
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_targets.out
