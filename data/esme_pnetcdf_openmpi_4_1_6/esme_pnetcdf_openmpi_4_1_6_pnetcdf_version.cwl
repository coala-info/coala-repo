cwlVersion: v1.2
class: CommandLineTool
baseCommand: pnetcdf_version
label: esme_pnetcdf_openmpi_4_1_6_pnetcdf_version
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
    dockerPull: quay.io/biocontainers/esme_pnetcdf_openmpi_4_1_6:1.14.0--hcc24ad4_0
stdout: esme_pnetcdf_openmpi_4_1_6_pnetcdf_version.out
