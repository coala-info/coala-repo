cwlVersion: v1.2
class: CommandLineTool
baseCommand: aster
label: aster
doc: "ASTER (Accurate Species Tree Estimator) - A tool for species tree estimation
  from gene trees or sequences.\n\nTool homepage: https://github.com/chaoszhang/ASTER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aster:1.23--h9948957_0
stdout: aster.out
