cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme
label: esme_netcdf-fortran_mvapich_4_0_ucx
doc: "The provided text contains system error messages related to a container runtime
  (Apptainer/Singularity) failure and does not contain the help documentation for
  the tool. No arguments could be extracted.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_mvapich_4_0_ucx.out
