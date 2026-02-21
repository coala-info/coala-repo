cwlVersion: v1.2
class: CommandLineTool
baseCommand: diffacto_diffacto.py
label: diffacto_diffacto.py
doc: "Differential abundance analysis tool (Note: The provided help text contains
  only system error messages and no argument information).\n\nTool homepage: https://github.com/statisticalbiotechnology/diffacto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diffacto:1.0.7--pyh7cba7a3_0
stdout: diffacto_diffacto.py.out
