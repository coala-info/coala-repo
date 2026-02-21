cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_12_1_mpirun
label: esme_psmpi_5_12_1_mpirun
doc: "The provided text does not contain help information for the tool; it contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  an image due to insufficient disk space.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_12_1_mpirun.out
