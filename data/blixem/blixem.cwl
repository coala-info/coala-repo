cwlVersion: v1.2
class: CommandLineTool
baseCommand: blixem
label: blixem
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a failure to pull or build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/blixem/blixem.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/blixem:v4.44.1dfsg-3-deb_cv1
stdout: blixem.out
