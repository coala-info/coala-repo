cwlVersion: v1.2
class: CommandLineTool
baseCommand: osu_bw
label: esme_mvapich_4_0_osu_bw
doc: "OSU Micro-Benchmarks - MPI Bandwidth Test. Note: The provided help text contains
  container runtime error messages rather than tool usage instructions.\n\nTool homepage:
  https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_osu_bw.out
