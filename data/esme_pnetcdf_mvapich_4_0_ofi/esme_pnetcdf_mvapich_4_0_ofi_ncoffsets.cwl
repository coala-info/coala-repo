cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_mvapich_4_0_ofi_ncoffsets
label: esme_pnetcdf_mvapich_4_0_ofi_ncoffsets
doc: "The provided text does not contain help information for the tool; it contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull or build an image due to insufficient disk space.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mvapich_4_0_ofi_ncoffsets.out
