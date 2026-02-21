cwlVersion: v1.2
class: CommandLineTool
baseCommand: gpatch
label: gpatch
doc: "The provided text does not contain help information for gpatch; it is an error
  log indicating a failure to build or pull a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/adadiehl/GPatch.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gpatch:0.4.0--pyhdfd78af_0
stdout: gpatch.out
