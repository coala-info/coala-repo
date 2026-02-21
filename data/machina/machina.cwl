cwlVersion: v1.2
class: CommandLineTool
baseCommand: machina
label: machina
doc: "A tool for phylogenetic inference of tumor history (Note: The provided text
  contains container runtime error messages rather than tool help text).\n\nTool homepage:
  https://github.com/raphael-group/machina"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina.out
