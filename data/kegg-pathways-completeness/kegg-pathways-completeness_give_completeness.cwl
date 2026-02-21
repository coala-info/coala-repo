cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kegg-pathways-completeness
  - give_completeness
label: kegg-pathways-completeness_give_completeness
doc: "A tool to calculate KEGG pathways completeness. Note: The provided help text
  contains system error messages and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/EBI-Metagenomics/kegg-pathways-completeness-tool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegg-pathways-completeness:1.3.0--pyhdfd78af_0
stdout: kegg-pathways-completeness_give_completeness.out
