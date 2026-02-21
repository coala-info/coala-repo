cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_hdf5_mvapich_4_0_ucx
label: esme_hdf5_mvapich_4_0_ucx
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log from a container runtime (Apptainer/Singularity) failing
  to pull or build the image due to insufficient disk space.\n\nTool homepage: https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_mvapich_4_0_ucx.out
