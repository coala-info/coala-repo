cwlVersion: v1.2
class: CommandLineTool
baseCommand: psirc-quant
label: psirc_psirc-quant
doc: "The provided text does not contain help or usage information for the tool; it
  is a log of a failed container build process. As a result, no arguments could be
  extracted.\n\nTool homepage: https://github.com/nictru/psirc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
stdout: psirc_psirc-quant.out
