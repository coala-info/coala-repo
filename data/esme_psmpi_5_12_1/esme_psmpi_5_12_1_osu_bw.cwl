cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_12_1_osu_bw
label: esme_psmpi_5_12_1_osu_bw
doc: "OSU MPI Bandwidth Test (Note: The provided help text contains container runtime
  error messages and does not list specific command-line arguments).\n\nTool homepage:
  https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_12_1_osu_bw.out
