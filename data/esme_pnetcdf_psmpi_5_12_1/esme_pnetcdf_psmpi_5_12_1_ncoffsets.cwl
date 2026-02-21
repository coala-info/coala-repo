cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_psmpi_5_12_1_ncoffsets
label: esme_pnetcdf_psmpi_5_12_1_ncoffsets
doc: "A tool for handling NetCDF offsets using PNetCDF and PSMPI. (Note: The provided
  help text contains only container runtime error logs and does not list specific
  command-line arguments.)\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_psmpi_5_12_1_ncoffsets.out
