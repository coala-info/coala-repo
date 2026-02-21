cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5ls
label: esme_hdf5_openmpi_5_0_7_h5ls
doc: "The h5ls tool is used to list the contents of an HDF5 file. (Note: The provided
  help text contains only system error messages regarding container image retrieval
  and does not list specific command-line arguments).\n\nTool homepage: https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_openmpi_5_0_7_h5ls.out
