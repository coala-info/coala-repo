cwlVersion: v1.2
class: CommandLineTool
baseCommand: d4binding
label: d4binding
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to extract
  the image due to lack of disk space.\n\nTool homepage: https://github.com/38/d4-format"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/d4binding:0.3.11--ha986137_4
stdout: d4binding.out
