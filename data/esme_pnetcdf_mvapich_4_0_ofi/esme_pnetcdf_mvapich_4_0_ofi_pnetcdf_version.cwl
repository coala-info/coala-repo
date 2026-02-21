cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_mvapich_4_0_ofi_pnetcdf_version
label: esme_pnetcdf_mvapich_4_0_ofi_pnetcdf_version
doc: "A tool to check the PNetCDF version for the ESME build with MVAPICH and OFI.\n
  \nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mvapich_4_0_ofi_pnetcdf_version.out
