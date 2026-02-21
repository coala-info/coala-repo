cwlVersion: v1.2
class: CommandLineTool
baseCommand: recalladapters
label: recalladapters
doc: "The provided text does not contain help information for the tool, but appears
  to be a container engine error log.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recalladapters:9.0.0--h9ee0642_1
stdout: recalladapters.out
