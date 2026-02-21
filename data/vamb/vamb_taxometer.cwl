cwlVersion: v1.2
class: CommandLineTool
baseCommand: vamb_taxometer
label: vamb_taxometer
doc: "The provided text is a system error log from a container build process and does
  not contain help documentation or argument definitions for the tool.\n\nTool homepage:
  https://github.com/RasmussenLab/vamb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vamb:5.0.4--pyhdfd78af_0
stdout: vamb_taxometer.out
