cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsderive
label: ngsderive
doc: "The provided text contains error logs from a container runtime environment and
  does not include the help documentation for the tool. As a result, no arguments
  or descriptions could be extracted.\n\nTool homepage: https://github.com/claymcleod/ngsderive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
stdout: ngsderive.out
