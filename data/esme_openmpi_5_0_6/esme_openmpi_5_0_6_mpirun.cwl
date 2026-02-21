cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun
label: esme_openmpi_5_0_6_mpirun
doc: "The provided text appears to be an error log from a container runtime (Apptainer/Singularity)
  rather than help text for the tool. No command-line arguments or usage information
  could be extracted from the input.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_openmpi_5_0_6_mpirun.out
