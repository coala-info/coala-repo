cwlVersion: v1.2
class: CommandLineTool
baseCommand: mi-pimento_gen_bcv
label: mi-pimento_gen_bcv
doc: "A tool within the mi-pimento suite (MicroRNA-PIpeline for MENTOr). Note: The
  provided text contains system error logs regarding container execution and does
  not include the actual help documentation or argument definitions.\n\nTool homepage:
  https://github.com/EBI-Metagenomics/PIMENTO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mi-pimento:1.0.2--pyhdfd78af_0
stdout: mi-pimento_gen_bcv.out
