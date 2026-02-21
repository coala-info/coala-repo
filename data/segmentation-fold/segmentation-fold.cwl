cwlVersion: v1.2
class: CommandLineTool
baseCommand: segmentation-fold
label: segmentation-fold
doc: "The provided text is a container build error log and does not contain help documentation
  or argument definitions for the tool.\n\nTool homepage: https://github.com/shreyapamecha/Speed-Estimation-of-Vehicles-with-Plate-Detection"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
stdout: segmentation-fold.out
