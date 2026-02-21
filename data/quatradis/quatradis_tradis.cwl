cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quatradis
  - tradis
label: quatradis_tradis
doc: "The provided text is a container runtime error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis.out
