cwlVersion: v1.2
class: CommandLineTool
baseCommand: osu_allreduce
label: esme_psmpi_5_12_1_osu_allreduce
doc: "OSU MPI Allreduce benchmark (Note: The provided help text contained only system
  error messages and no usage information; arguments could not be extracted).\n\n
  Tool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_12_1_osu_allreduce.out
