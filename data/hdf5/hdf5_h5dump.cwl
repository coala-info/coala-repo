cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5dump
label: hdf5_h5dump
doc: "The provided text does not contain help information for h5dump; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the container image due to lack of disk space.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5dump.out
