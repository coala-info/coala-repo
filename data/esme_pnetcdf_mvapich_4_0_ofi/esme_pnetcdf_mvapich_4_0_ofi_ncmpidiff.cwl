cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncmpidiff
label: esme_pnetcdf_mvapich_4_0_ofi_ncmpidiff
doc: "The provided text does not contain help information as it is an error log reporting
  a 'no space left on device' failure during a container build. ncmpidiff is typically
  used to compare two PnetCDF files.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mvapich_4_0_ofi_ncmpidiff.out
