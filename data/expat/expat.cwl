cwlVersion: v1.2
class: CommandLineTool
baseCommand: expat
label: expat
doc: "The provided text does not contain help information for the expat tool; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/xmppo/node-expat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expat:2.1.0--0
stdout: expat.out
