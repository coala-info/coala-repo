cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun
label: esme_mvapich_4_0_ofi_mpirun
doc: "MPI runner for ESME (Energy Exascale Earth System Model) configured with MVAPICH
  and NetCDF-Fortran. Note: The provided text is an error log and does not contain
  usage instructions or argument definitions.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_ofi_mpirun.out
