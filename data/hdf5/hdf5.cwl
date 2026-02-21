cwlVersion: v1.2
class: CommandLineTool
baseCommand: hdf5
label: hdf5
doc: "The provided text does not contain help information for the hdf5 tool. It is
  an error log from a container runtime (Apptainer/Singularity) reporting a failure
  to build a SIF image from a Docker URI due to insufficient disk space.\n\nTool homepage:
  https://github.com/HDFGroup/hdf5"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5.out
