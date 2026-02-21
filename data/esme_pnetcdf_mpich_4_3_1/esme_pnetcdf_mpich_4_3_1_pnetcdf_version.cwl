cwlVersion: v1.2
class: CommandLineTool
baseCommand: pnetcdf_version
label: esme_pnetcdf_mpich_4_3_1_pnetcdf_version
doc: "A tool to display the version information of the PnetCDF library.\n\nTool homepage:
  https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mpich_4_3_1_pnetcdf_version.out
