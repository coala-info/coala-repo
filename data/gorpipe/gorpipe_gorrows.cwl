cwlVersion: v1.2
class: CommandLineTool
baseCommand: gorrows
label: gorpipe_gorrows
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log related to a container execution failure (no space left
  on device).\n\nTool homepage: https://github.com/gorpipe/gor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gorpipe:4.5.0--hdfd78af_0
stdout: gorpipe_gorrows.out
