cwlVersion: v1.2
class: CommandLineTool
baseCommand: libdeflate
label: libdeflate
doc: "The provided text does not contain help information for libdeflate; it is an
  error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/ebiggers/libdeflate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libdeflate:1.2--h14c3975_0
stdout: libdeflate.out
