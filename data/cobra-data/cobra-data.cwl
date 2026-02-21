cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobra-data
label: cobra-data
doc: "The provided text does not contain help information for the tool, but rather
  log messages from a container runtime (Apptainer/Singularity) indicating a failure
  to build or run the container due to lack of disk space.\n\nTool homepage: https://opencobra.github.io/cobrapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cobra-data:v0.14.1-1-deb-py2_cv1
stdout: cobra-data.out
