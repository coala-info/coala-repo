cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mvapich_4_0_ucx_osu_bw
label: esme_mvapich_4_0_ucx_osu_bw
doc: "OSU Micro-Benchmarks bandwidth test (Note: The provided text is a container
  runtime error log and does not contain command-line help information).\n\nTool homepage:
  https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_ucx_osu_bw.out
