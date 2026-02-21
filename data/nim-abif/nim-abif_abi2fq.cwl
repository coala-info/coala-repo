cwlVersion: v1.2
class: CommandLineTool
baseCommand: nim-abif_abi2fq
label: nim-abif_abi2fq
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error indicating a failure to build the image
  due to lack of disk space.\n\nTool homepage: https://github.com/quadram-institute-bioscience/nim-abif"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
stdout: nim-abif_abi2fq.out
