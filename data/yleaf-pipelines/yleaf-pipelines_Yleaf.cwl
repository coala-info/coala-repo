cwlVersion: v1.2
class: CommandLineTool
baseCommand: Yleaf
label: yleaf-pipelines_Yleaf
doc: "The provided text does not contain help information; it is a log of a failed
  container build/fetch operation.\n\nTool homepage: https://github.com/trianglegrrl/Yleaf-pipelines"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yleaf-pipelines:3.3.0--pyh7e72e81_0
stdout: yleaf-pipelines_Yleaf.out
