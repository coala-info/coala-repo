cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pnetcdf_mvapich_4_0_ucx_pnetcdf_version
label: esme_pnetcdf_mvapich_4_0_ucx_pnetcdf_version
doc: "PnetCDF Version and Release Information\n\nTool homepage: https://parallel-netcdf.github.io/"
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
    doc: MPICC compiler command and flags
    inputBinding:
      position: 4
  - id: mpicxx
    type:
      - 'null'
      - string
    doc: MPICXX compiler command and flags
    inputBinding:
      position: 5
  - id: mpif77
    type:
      - 'null'
      - string
    doc: MPIF77 compiler command and flags
    inputBinding:
      position: 6
  - id: mpif90
    type:
      - 'null'
      - string
    doc: MPIF90 compiler command and flags
    inputBinding:
      position: 7
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ucx:1.14.1--hf580d27_0
stdout: esme_pnetcdf_mvapich_4_0_ucx_pnetcdf_version.out
