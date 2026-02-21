cwlVersion: v1.2
class: CommandLineTool
baseCommand: starfish
label: starfish
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/execution process.\n\nTool homepage:
  https://github.com/spacetx/starfish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/starfish:0.4.0--pyhdfd78af_0
stdout: starfish.out
