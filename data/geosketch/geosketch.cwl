cwlVersion: v1.2
class: CommandLineTool
baseCommand: geosketch
label: geosketch
doc: "The provided text does not contain help information for the tool. It contains
  error messages from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container image due to lack of disk space.\n\nTool homepage: https://github.com/brianhie/geosketch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geosketch:1.3--pyhdfd78af_0
stdout: geosketch.out
