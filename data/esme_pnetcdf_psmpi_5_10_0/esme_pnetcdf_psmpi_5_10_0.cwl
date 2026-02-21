cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_psmpi_5_10_0
label: esme_pnetcdf_psmpi_5_10_0
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build a SIF image due to insufficient disk space.\n\nTool homepage:
  https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_psmpi_5_10_0.out
