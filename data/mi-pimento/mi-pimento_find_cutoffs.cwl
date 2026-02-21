cwlVersion: v1.2
class: CommandLineTool
baseCommand: mi-pimento_find_cutoffs
label: mi-pimento_find_cutoffs
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error logs.\n\nTool homepage: https://github.com/EBI-Metagenomics/PIMENTO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mi-pimento:1.0.2--pyhdfd78af_0
stdout: mi-pimento_find_cutoffs.out
