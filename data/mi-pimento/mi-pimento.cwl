cwlVersion: v1.2
class: CommandLineTool
baseCommand: mi-pimento
label: mi-pimento
doc: "A tool for piRNA annotation and analysis (Note: The provided text is an error
  log and does not contain usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/EBI-Metagenomics/PIMENTO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mi-pimento:1.0.2--pyhdfd78af_0
stdout: mi-pimento.out
