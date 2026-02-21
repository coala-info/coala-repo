cwlVersion: v1.2
class: CommandLineTool
baseCommand: nccopy
label: esme_netcdf-c_mpich_4_3_1_nccopy
doc: "Copy a netCDF file, optionally changing format, compression, or chunking in
  the output.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_mpich_4_3_1_nccopy.out
