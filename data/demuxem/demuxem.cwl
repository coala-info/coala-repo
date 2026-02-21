cwlVersion: v1.2
class: CommandLineTool
baseCommand: demuxem
label: demuxem
doc: "The provided text does not contain help information or usage instructions for
  demuxem; it is an error log indicating a failure to build or run a container due
  to lack of disk space.\n\nTool homepage: https://github.com/klarman-cell-observatory/demuxEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demuxem:0.1.8--pyhdfd78af_0
stdout: demuxem.out
