cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoget
label: nanoget
doc: "The provided text does not contain help information as it is an error log indicating
  a failure to pull or build the container image (no space left on device).\n\nTool
  homepage: https://github.com/wdecoster/nanoget"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoget:1.19.4--pyhdfd78af_0
stdout: nanoget.out
