cwlVersion: v1.2
class: CommandLineTool
baseCommand: genedom
label: genedom
doc: "A tool for genetic design and assembly (Note: The provided help text contains
  only container execution errors and no usage information).\n\nTool homepage: https://github.com/Edinburgh-Genome-Foundry/genedom#"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genedom:0.2.2--pyh7e72e81_0
stdout: genedom.out
