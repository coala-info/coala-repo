cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpiexec
label: esme_omb_openmpi_4_1_6_mpiexec
doc: "The provided text is an error log from a container runtime environment and does
  not contain help documentation for the tool. Based on the tool name, this appears
  to be an mpiexec wrapper for ESME (Energy Exascale Earth System Model) OSU Micro-Benchmarks
  using OpenMPI 4.1.6.\n\nTool homepage: https://mvapich.cse.ohio-state.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_omb_openmpi_4_1_6_mpiexec.out
