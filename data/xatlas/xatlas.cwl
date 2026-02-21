cwlVersion: v1.2
class: CommandLineTool
baseCommand: xatlas
label: xatlas
doc: "The provided text is a container engine error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: https://github.com/jfarek/xatlas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xatlas:0.3--h9948957_5
stdout: xatlas.out
