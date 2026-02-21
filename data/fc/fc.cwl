cwlVersion: v1.2
class: CommandLineTool
baseCommand: fc
label: fc
doc: "The provided text does not contain help information for the tool 'fc'. It is
  an error log indicating a failure to build or run a container due to insufficient
  disk space.\n\nTool homepage: https://github.com/qdu-bioinfo/fc-virus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fc:1.0.1--h5ca1c30_1
stdout: fc.out
