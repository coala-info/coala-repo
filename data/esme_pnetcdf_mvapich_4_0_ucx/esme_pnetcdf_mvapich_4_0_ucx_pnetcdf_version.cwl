cwlVersion: v1.2
class: CommandLineTool
baseCommand: pnetcdf_version
label: esme_pnetcdf_mvapich_4_0_ucx_pnetcdf_version
doc: "PnetCDF Version Information: prints the version, release date, configure arguments
  and MPI compilers of the PnetCDF library.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs:
  - id: version_number
    type:
      - 'null'
      - boolean
    doc: version number
    inputBinding:
      position: 1
      prefix: -v
  - id: release_date
    type:
      - 'null'
      - boolean
    doc: release date
    inputBinding:
      position: 1
      prefix: -d
  - id: configure_args
    type:
      - 'null'
      - boolean
    doc: configure arguments used to build PnetCDF
    inputBinding:
      position: 1
      prefix: -c
  - id: mpi_compilers
    type:
      - 'null'
      - boolean
    doc: MPI compilers used
    inputBinding:
      position: 1
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ucx:1.14.1--hf580d27_0
stdout: esme_pnetcdf_mvapich_4_0_ucx_pnetcdf_version.out
