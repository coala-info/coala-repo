cwlVersion: v1.2
class: CommandLineTool
baseCommand: diapysef
label: diapysef
doc: "A tool for analyzing dia-PASEF data. (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  CLI arguments.)\n\nTool homepage: https://github.com/Roestlab/dia-pasef"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
stdout: diapysef.out
