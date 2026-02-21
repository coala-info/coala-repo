cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnvetti
label: cnvetti
doc: "A tool for CNV (Copy Number Variation) analysis (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/bihealth/cnvetti"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
stdout: cnvetti.out
