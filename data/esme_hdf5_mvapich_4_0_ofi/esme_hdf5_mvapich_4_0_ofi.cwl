cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_hdf5_mvapich_4_0_ofi
label: esme_hdf5_mvapich_4_0_ofi
doc: "The provided text is a container runtime error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_mvapich_4_0_ofi.out
