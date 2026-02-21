cwlVersion: v1.2
class: CommandLineTool
baseCommand: krbalancing
label: krbalancing
doc: "Knight-Ruiz balancing (Note: The provided text is a container execution error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/deeptools/Knight-Ruiz-Matrix-balancing-algorithm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krbalancing:0.0.5--py311he264feb_11
stdout: krbalancing.out
