cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_openmpi_4_1_6_ncoffsets
label: esme_pnetcdf_openmpi_4_1_6_ncoffsets
doc: "A tool related to ESME (Energy Exascale Earth System Model) and Parallel NetCDF
  (pnetcdf) with OpenMPI support. Note: The provided input text contains container
  runtime error messages rather than tool usage instructions.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_openmpi_4_1_6_ncoffsets.out
