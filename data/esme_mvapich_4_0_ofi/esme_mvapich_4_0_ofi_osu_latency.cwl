cwlVersion: v1.2
class: CommandLineTool
baseCommand: osu_latency
label: esme_mvapich_4_0_ofi_osu_latency
doc: "OSU Micro-Benchmarks latency test (MVAPICH2-OFI). Note: The provided help text
  contains container runtime error messages and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_ofi_osu_latency.out
