cwlVersion: v1.2
class: CommandLineTool
baseCommand: radsex
label: radsex
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a container runtime error log.\n\nTool homepage: https://github.com/RomainFeron/RadSex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radsex:1.2.0--h43eeafb_3
stdout: radsex.out
