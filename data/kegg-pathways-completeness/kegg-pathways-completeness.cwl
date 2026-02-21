cwlVersion: v1.2
class: CommandLineTool
baseCommand: kegg-pathways-completeness
label: kegg-pathways-completeness
doc: "A tool to calculate the completeness of KEGG pathways. (Note: The provided text
  is a system error log and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/EBI-Metagenomics/kegg-pathways-completeness-tool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegg-pathways-completeness:1.3.0--pyhdfd78af_0
stdout: kegg-pathways-completeness.out
