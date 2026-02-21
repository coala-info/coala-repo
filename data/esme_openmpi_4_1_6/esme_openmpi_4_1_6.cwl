cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme
label: esme_openmpi_4_1_6
doc: "The provided text contains error logs from a container runtime (Apptainer/Singularity)
  and does not include help documentation or usage instructions for the tool. As a
  result, no arguments could be extracted.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_openmpi_4_1_6.out
