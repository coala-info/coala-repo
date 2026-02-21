cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_10_0_osu_latency
label: esme_psmpi_5_10_0_osu_latency
doc: "OSU Latency Test (Note: The provided text is an error log from a container runtime
  and does not contain tool-specific help or usage information).\n\nTool homepage:
  https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_10_0_osu_latency.out
