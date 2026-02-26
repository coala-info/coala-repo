cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_openmpi_4_1_6_pnetcdf_version
label: esme_pnetcdf_openmpi_4_1_6_pnetcdf_version
doc: "PnetCDF Version Information\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs:
  - id: pnetcdf_version
    type:
      - 'null'
      - string
    doc: PnetCDF Version
    inputBinding:
      position: 1
  - id: pnetcdf_release_date
    type:
      - 'null'
      - string
    doc: PnetCDF Release date
    inputBinding:
      position: 2
  - id: pnetcdf_configure
    type:
      - 'null'
      - string
    doc: PnetCDF configure options
    inputBinding:
      position: 3
  - id: mpicc
    type:
      - 'null'
      - string
    doc: MPICC command and flags
    inputBinding:
      position: 4
  - id: mpicxx
    type:
      - 'null'
      - string
    doc: MPICXX command and flags
    inputBinding:
      position: 5
  - id: mpif77
    type:
      - 'null'
      - string
    doc: MPIF77 command and flags
    inputBinding:
      position: 6
  - id: mpif90
    type:
      - 'null'
      - string
    doc: MPIF90 command and flags
    inputBinding:
      position: 7
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/esme_pnetcdf_openmpi_4_1_6:1.14.0--hcc24ad4_0
stdout: esme_pnetcdf_openmpi_4_1_6_pnetcdf_version.out
