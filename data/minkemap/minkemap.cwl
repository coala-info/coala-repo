cwlVersion: v1.2
class: CommandLineTool
baseCommand: minkemap
label: minkemap
doc: "The provided text does not contain help information or usage instructions. It
  consists of error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/erinyoung/MinkeMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minkemap:0.1.0--pyhdfd78af_0
stdout: minkemap.out
