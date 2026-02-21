cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpicc
label: esme_mvapich_4_0_ucx_mpicc
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the container image due to insufficient disk
  space ('no space left on device'). It does not contain help documentation or argument
  definitions for the tool.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_ucx_mpicc.out
