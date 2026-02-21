cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanocall
label: nanocall
doc: "The provided text does not contain help information or usage instructions for
  nanocall. It appears to be a system error log related to a container runtime (Apptainer/Singularity)
  failing due to insufficient disk space.\n\nTool homepage: https://github.com/WGLab/NanoCaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanocall:v0.7.4--0
stdout: nanocall.out
