cwlVersion: v1.2
class: CommandLineTool
baseCommand: isescan
label: isescan
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/xiezhq/ISEScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isescan:1.7.3--h7b50bb2_0
stdout: isescan.out
