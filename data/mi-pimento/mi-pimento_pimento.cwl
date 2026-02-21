cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mi-pimento
  - pimento
label: mi-pimento_pimento
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains container runtime log messages and a fatal error
  regarding disk space.\n\nTool homepage: https://github.com/EBI-Metagenomics/PIMENTO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mi-pimento:1.0.2--pyhdfd78af_0
stdout: mi-pimento_pimento.out
