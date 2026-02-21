cwlVersion: v1.2
class: CommandLineTool
baseCommand: famus
label: famus_famus-defaults
doc: "FAMUS (Fast and Accurate Methylation Utility Software). Note: The provided help
  text contains only system error messages and no usage information.\n\nTool homepage:
  https://github.com/burstein-lab/famus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
stdout: famus_famus-defaults.out
