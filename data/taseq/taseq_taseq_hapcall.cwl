cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taseq
  - hapcall
label: taseq_taseq_hapcall
doc: "Haplotype calling tool from the taseq package. (Note: The provided text contains
  container engine logs and does not include usage or argument information.)\n\nTool
  homepage: https://github.com/KChigira/taseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taseq:1.1.1--pyh7e72e81_0
stdout: taseq_taseq_hapcall.out
