cwlVersion: v1.2
class: CommandLineTool
baseCommand: palantir
label: palantir
doc: "Palantir is a tool for trajectory inference and cell fate determination in single-cell
  data. (Note: The provided text contains system error messages rather than command-line
  help documentation.)\n\nTool homepage: https://github.com/dpeerlab/palantir"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/palantir:1.4.4--pyh106432d_0
stdout: palantir.out
