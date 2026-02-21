cwlVersion: v1.2
class: CommandLineTool
baseCommand: flock
label: flock
doc: "The provided text does not contain help information for the tool 'flock'. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or pull the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/ClusterHQ/flocker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flock:1.0--0
stdout: flock.out
