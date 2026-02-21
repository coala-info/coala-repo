cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequencetools
label: sequencetools
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failure to build or extract a container image
  (sequencetools:1.6.0.0) due to insufficient disk space ('no space left on device').\n
  \nTool homepage: https://github.com/stschiff/sequenceTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequencetools:1.6.0.0--hebebf5b_0
stdout: sequencetools.out
