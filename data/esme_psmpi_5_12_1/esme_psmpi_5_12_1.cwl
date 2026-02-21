cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_12_1
label: esme_psmpi_5_12_1
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to pull
  or build an image due to lack of disk space.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_12_1.out
