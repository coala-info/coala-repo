cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigtools
label: bigtools
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failure to build or extract a container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/jackh726/bigtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
stdout: bigtools.out
