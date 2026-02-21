cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5ls
label: hdf5_h5ls
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull a Docker image due to insufficient disk space.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5ls.out
