cwlVersion: v1.2
class: CommandLineTool
baseCommand: d4tools
label: d4tools
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to extract the d4tools image due to insufficient disk space.\n\nTool homepage: https://github.com/38/d4-format"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/d4tools:0.3.11--ha986137_3
stdout: d4tools.out
