cwlVersion: v1.2
class: CommandLineTool
baseCommand: lodei
label: lodei
doc: "LODEI (LOng-read DE novo Isoform discovery) is a tool for identifying isoforms
  from long-read sequencing data.\n\nTool homepage: https://github.com/rna-editing1/lodei"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lodei:1.1.1--pyh7e72e81_0
stdout: lodei.out
