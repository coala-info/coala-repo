cwlVersion: v1.2
class: CommandLineTool
baseCommand: segtools
label: segtools
doc: "The provided text does not contain help information or documentation for the
  tool. It is a system error log indicating a failure to build or run a container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/GuoBioinfoLab/SEGtool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segtools:1.3.0--pyh7cba7a3_0
stdout: segtools.out
