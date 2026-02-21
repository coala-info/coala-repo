cwlVersion: v1.2
class: CommandLineTool
baseCommand: bindash
label: bindash
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF image due to lack of disk space.\n\nTool homepage: https://github.com/zhaoxiaofei/bindash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bindash:2.6--h077b44d_0
stdout: bindash.out
