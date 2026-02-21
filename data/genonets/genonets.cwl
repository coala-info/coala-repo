cwlVersion: v1.2
class: CommandLineTool
baseCommand: genonets
label: genonets
doc: "Genonets is a tool for the construction and analysis of genotype networks. (Note:
  The provided input text contains system error messages and does not include the
  tool's help documentation.)\n\nTool homepage: https://github.com/fkhalid/genonets"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genonets:2.0--pyh5e36f6f_0
stdout: genonets.out
