cwlVersion: v1.2
class: CommandLineTool
baseCommand: coidb
label: coidb
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a 'no space left on device' failure during
  a container pull.\n\nTool homepage: https://github.com/johnne/coidb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coidb:0.4.8--pyhdfd78af_0
stdout: coidb.out
