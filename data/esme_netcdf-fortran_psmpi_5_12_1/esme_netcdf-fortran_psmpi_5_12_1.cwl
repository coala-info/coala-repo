cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_netcdf-fortran_psmpi_5_12_1
label: esme_netcdf-fortran_psmpi_5_12_1
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the container image due to insufficient disk
  space.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_psmpi_5_12_1.out
