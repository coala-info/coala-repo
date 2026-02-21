cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastlin
label: fastlin
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container due to lack of disk space.\n\nTool homepage: https://github.com/rderelle/fastlin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastlin:0.4.2.1--h4349ce8_0
stdout: fastlin.out
