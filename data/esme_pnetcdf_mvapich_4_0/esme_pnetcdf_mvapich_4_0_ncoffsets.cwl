cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_mvapich_4_0_ncoffsets
label: esme_pnetcdf_mvapich_4_0_ncoffsets
doc: "A tool related to ESME (Energy Exascale Earth System Model) utilizing PNetCDF
  and MVAPICH.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mvapich_4_0_ncoffsets.out
