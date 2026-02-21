cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_omb_openmpi_4_1_6_mpirun
label: esme_omb_openmpi_4_1_6_mpirun
doc: "The provided text does not contain help information or usage instructions; it
  contains error logs related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_openmpi_4_1_6_mpirun.out
