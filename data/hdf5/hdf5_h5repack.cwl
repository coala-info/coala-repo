cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5repack
label: hdf5_h5repack
doc: "The provided text does not contain help information for h5repack; it contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build an image due to insufficient disk space.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5repack.out
