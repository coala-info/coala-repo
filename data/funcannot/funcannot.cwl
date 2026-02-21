cwlVersion: v1.2
class: CommandLineTool
baseCommand: funcannot
label: funcannot
doc: "Functional annotation of genomes (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/BioTools-Tek/funcannot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funcannot:v2.8--0
stdout: funcannot.out
