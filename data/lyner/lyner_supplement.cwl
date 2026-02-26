cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - supplement
label: lyner_supplement
doc: "Supply additional data which may be used for plot colors, for example.\n\nTool
  homepage: https://github.com/tedil/lyner"
inputs:
  - id: supplementary_data
    type: string
    doc: Supplementary data
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_supplement.out
