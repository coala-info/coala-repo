cwlVersion: v1.2
class: CommandLineTool
baseCommand: rattle
label: rattle
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/execution attempt.\n\nTool homepage:
  https://github.com/comprna/RATTLE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
stdout: rattle.out
