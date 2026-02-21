cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncgen
label: esme_netcdf-c_mvapich_4_0_ucx_ncgen
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space ('no space
  left on device').\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_mvapich_4_0_ucx_ncgen.out
