cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellpose
label: cellpose
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build or extract the image due to lack of disk space.\n\nTool homepage:
  https://github.com/MouseLand/cellpose"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellpose:4.0.8
stdout: cellpose.out
