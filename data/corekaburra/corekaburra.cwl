cwlVersion: v1.2
class: CommandLineTool
baseCommand: corekaburra
label: corekaburra
doc: "Corekaburra is a tool for analyzing pangenomes, but the provided text contains
  only system error logs and no usage information.\n\nTool homepage: https://github.com/milnus/Corekaburra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/corekaburra:0.0.5--pyhdfd78af_0
stdout: corekaburra.out
