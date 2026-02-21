cwlVersion: v1.2
class: CommandLineTool
baseCommand: cherri
label: cherri
doc: "No description available from the provided text.\n\nTool homepage: https://github.com/BackofenLab/Cherri"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cherri:0.8--pyh7cba7a3_0
stdout: cherri.out
