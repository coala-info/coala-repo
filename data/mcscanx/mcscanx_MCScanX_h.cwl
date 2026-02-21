cwlVersion: v1.2
class: CommandLineTool
baseCommand: MCScanX
label: mcscanx_MCScanX_h
doc: "MCScanX: Multiple Collinearity Scan toolkit. (Note: The provided help text contains
  only system error messages regarding a container runtime failure and does not list
  command-line arguments.)\n\nTool homepage: https://github.com/wyp1125/MCScanX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx_MCScanX_h.out
