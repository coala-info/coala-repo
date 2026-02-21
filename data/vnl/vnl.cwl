cwlVersion: v1.2
class: CommandLineTool
baseCommand: vnl
label: vnl
doc: "The provided text is a container build error log and does not contain help information
  or usage instructions for the 'vnl' tool.\n\nTool homepage: https://github.com/YvanYin/VNL_Monocular_Depth_Prediction"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vnl:1.17.0--0
stdout: vnl.out
