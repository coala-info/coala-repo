cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5stat
label: esme_hdf5_openmpi_5_0_7_h5stat
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_openmpi_5_0_7_h5stat.out
