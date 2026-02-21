cwlVersion: v1.2
class: CommandLineTool
baseCommand: smudgeplot_rn
label: smudgeplot_rn
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a container runtime error log.\n\nTool homepage: https://github.com/RNieuwenhuis/smudgeplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_rn.out
