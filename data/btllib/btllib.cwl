cwlVersion: v1.2
class: CommandLineTool
baseCommand: btllib
label: btllib
doc: "No description available from the provided text.\n\nTool homepage: https://github.com/bcgsc/btllib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/btllib:1.7.5--py39h6522958_0
stdout: btllib.out
