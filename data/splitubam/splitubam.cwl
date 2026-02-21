cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitubam
label: splitubam
doc: "The provided text does not contain help information for the tool 'splitubam'.
  It appears to be a log of a failed container build/fetch process.\n\nTool homepage:
  https://github.com/fellen31/splitubam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splitubam:0.1.1--ha96b9cd_1
stdout: splitubam.out
