cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_psmpi_5_10_0_ncoffsets
label: esme_pnetcdf_psmpi_5_10_0_ncoffsets
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool.\n\nTool
  homepage: https://parallel-netcdf.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_psmpi_5_10_0_ncoffsets.out
