cwlVersion: v1.2
class: CommandLineTool
baseCommand: mi-pimento_choose_primer_cutoff
label: mi-pimento_choose_primer_cutoff
doc: "Choose primer cutoff for mi-pimento (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/EBI-Metagenomics/PIMENTO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mi-pimento:1.0.2--pyhdfd78af_0
stdout: mi-pimento_choose_primer_cutoff.out
