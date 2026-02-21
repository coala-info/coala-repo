cwlVersion: v1.2
class: CommandLineTool
baseCommand: usher
label: usher
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log messages and a fatal error regarding image
  retrieval.\n\nTool homepage: https://github.com/yatisht/usher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usher:0.6.6--h719ac0c_1
stdout: usher.out
