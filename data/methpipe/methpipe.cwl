cwlVersion: v1.2
class: CommandLineTool
baseCommand: methpipe
label: methpipe
doc: "The provided text does not contain help information for the tool, but rather
  an error message indicating a failure to build the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/smithlabcode/methpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
stdout: methpipe.out
