cwlVersion: v1.2
class: CommandLineTool
baseCommand: hocort
label: hocort
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/ignasrum/hocort"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
stdout: hocort.out
