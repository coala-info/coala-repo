cwlVersion: v1.2
class: CommandLineTool
baseCommand: axiome
label: axiome_ui
doc: "AXIOME (Automated eXploration of Microbial Ecology) terminal user interface.\n
  \nTool homepage: https://github.com/ujjwalredd/Axiomeer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/axiome:2.0.4--py27_0
stdout: axiome_ui.out
