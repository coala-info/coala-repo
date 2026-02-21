cwlVersion: v1.2
class: CommandLineTool
baseCommand: gothresher
label: gothresher
doc: "A tool for processing or 'threshing' data (description not available in provided
  error log).\n\nTool homepage: https://github.com/FriedbergLab/GOThresher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gothresher:1.0.29--pyh7cba7a3_0
stdout: gothresher.out
