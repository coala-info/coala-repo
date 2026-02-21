cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_hdf5_openmpi_4_1_6
label: esme_hdf5_openmpi_4_1_6
doc: "The provided text contains system error messages related to a container runtime
  (Apptainer/Singularity) failure and does not contain help documentation or argument
  definitions for the tool.\n\nTool homepage: https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_openmpi_4_1_6.out
