cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtf_to_genes
label: gtf_to_genes
doc: "A tool for converting GTF files to gene-based formats. (Note: The provided help
  text contains only system error messages and does not list specific arguments or
  usage instructions.)\n\nTool homepage: https://github.com/bunbun/gtf-to-genes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtf_to_genes:1.40--py27_0
stdout: gtf_to_genes.out
