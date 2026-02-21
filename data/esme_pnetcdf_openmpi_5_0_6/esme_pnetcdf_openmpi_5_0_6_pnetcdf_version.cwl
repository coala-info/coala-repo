cwlVersion: v1.2
class: CommandLineTool
baseCommand: pnetcdf_version
label: esme_pnetcdf_openmpi_5_0_6_pnetcdf_version
doc: "A tool to report the version and build configuration of the Parallel netCDF
  (PnetCDF) library.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_openmpi_5_0_6_pnetcdf_version.out
