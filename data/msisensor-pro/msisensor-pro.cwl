cwlVersion: v1.2
class: CommandLineTool
baseCommand: msisensor-pro
label: msisensor-pro
doc: "The provided text does not contain help information for msisensor-pro; it is
  an error log indicating a failure to build or run the container due to lack of disk
  space.\n\nTool homepage: https://github.com/xjtu-omics/msisensor-pro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
stdout: msisensor-pro.out
