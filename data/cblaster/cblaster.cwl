cwlVersion: v1.2
class: CommandLineTool
baseCommand: cblaster
label: cblaster
doc: "The provided text does not contain help documentation for cblaster; it is an
  error log reporting a failure to build or extract a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
stdout: cblaster.out
