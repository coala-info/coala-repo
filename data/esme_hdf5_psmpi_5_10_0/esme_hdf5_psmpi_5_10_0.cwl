cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_hdf5_psmpi_5_10_0
label: esme_hdf5_psmpi_5_10_0
doc: "Evolution of Spectra in the Main Injector (ESME) simulation tool. (Note: The
  provided text contains system error logs regarding container image conversion and
  does not include usage instructions or argument definitions.)\n\nTool homepage:
  https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_psmpi_5_10_0.out
