cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_mpich_4_2_3_ncoffsets
label: esme_pnetcdf_mpich_4_2_3_ncoffsets
doc: "The provided text does not contain help documentation for the tool, but rather
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to insufficient disk space.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mpich_4_2_3_ncoffsets.out
