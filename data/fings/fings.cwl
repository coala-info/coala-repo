cwlVersion: v1.2
class: CommandLineTool
baseCommand: fings
label: fings
doc: "The provided text does not contain help information for the tool 'fings'; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container due to insufficient disk space.\n\nTool homepage: https://github.com/cpwardell/FiNGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fings:1.7.1--pyhb7b1952_0
stdout: fings.out
