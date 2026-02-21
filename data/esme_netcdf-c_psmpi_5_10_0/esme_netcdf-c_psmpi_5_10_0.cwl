cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_netcdf-c_psmpi_5_10_0
label: esme_netcdf-c_psmpi_5_10_0
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build a SIF image due to lack of disk space.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_psmpi_5_10_0.out
