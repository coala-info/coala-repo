cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mvapich_4_0_ucx_osu_latency
label: esme_mvapich_4_0_ucx_osu_latency
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to pull and convert a Docker image due to insufficient disk
  space.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_ucx_osu_latency.out
