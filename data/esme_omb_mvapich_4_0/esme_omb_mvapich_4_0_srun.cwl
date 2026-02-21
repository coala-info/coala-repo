cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_mvapich_4_0_srun
label: esme_omb_mvapich_4_0_srun
doc: "The provided text appears to be an error log from a container runtime (Apptainer/Singularity)
  rather than help text for the tool. No command-line arguments, flags, or usage instructions
  were found in the input.\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_mvapich_4_0_srun.out
