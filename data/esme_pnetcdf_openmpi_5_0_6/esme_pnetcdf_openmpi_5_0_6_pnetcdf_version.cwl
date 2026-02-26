cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_openmpi_5_0_6_pnetcdf_version
label: esme_pnetcdf_openmpi_5_0_6_pnetcdf_version
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
    doc: MPICC compiler command
    inputBinding:
      position: 4
  - id: mpicxx
    type:
      - 'null'
      - string
    doc: MPICXX compiler command
    inputBinding:
      position: 5
  - id: mpif77
    type:
      - 'null'
      - string
    doc: MPIF77 compiler command
    inputBinding:
      position: 6
  - id: mpif90
    type:
      - 'null'
      - string
    doc: MPIF90 compiler command
    inputBinding:
      position: 7
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/esme_pnetcdf_openmpi_5_0_6:1.14.0--h1080dc9_0
stdout: esme_pnetcdf_openmpi_5_0_6_pnetcdf_version.out
