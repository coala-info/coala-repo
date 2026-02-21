cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_hdf5_mpich_4_3_1
label: esme_hdf5_mpich_4_3_1
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container image build failure (no space left on device).\n
  \nTool homepage: https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_mpich_4_3_1.out
