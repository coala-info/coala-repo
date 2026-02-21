cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnarrange_lastal
label: dnarrange_lastal
doc: "A tool for structural variant discovery (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/mcfrith/dnarrange"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnarrange:1.6.3--pyh7e72e81_0
stdout: dnarrange_lastal.out
