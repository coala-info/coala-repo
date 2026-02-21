cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_hdf5_mvapich_4_0
label: esme_hdf5_mvapich_4_0
doc: "The provided text contains system error logs related to container image retrieval
  and does not include help documentation or usage instructions for the tool.\n\n
  Tool homepage: https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_mvapich_4_0.out
