cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_hdf5_psmpi_5_12_1
label: esme_hdf5_psmpi_5_12_1
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages regarding a failed image build due to insufficient
  disk space.\n\nTool homepage: https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_psmpi_5_12_1.out
