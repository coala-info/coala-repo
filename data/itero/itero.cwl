cwlVersion: v1.2
class: CommandLineTool
baseCommand: itero
label: itero
doc: "Iterative assembly of genomic data (Note: The provided text is a system error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/faircloth-lab/itero"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itero:1.1.2--py27_0
stdout: itero.out
