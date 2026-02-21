cwlVersion: v1.2
class: CommandLineTool
baseCommand: chia-rep
label: chia-rep
doc: "ChIA-PET reproducibility analysis tool (Note: The provided text is a container
  build error log and does not contain help information or argument definitions).\n
  \nTool homepage: https://github.com/c0ver/chia_rep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chia-rep:3.1.1--py310h068649b_3
stdout: chia-rep.out
