cwlVersion: v1.2
class: CommandLineTool
baseCommand: nf-config
label: esme_netcdf-fortran_openmpi_5_0_7_nf-config
doc: "NetCDF-Fortran configuration utility to retrieve compiler flags, library locations,
  and configuration settings.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Display all configuration options
    inputBinding:
      position: 101
      prefix: --all
  - id: cc
    type:
      - 'null'
      - boolean
    doc: Display the C compiler used
    inputBinding:
      position: 101
      prefix: --cc
  - id: cflags
    type:
      - 'null'
      - boolean
    doc: Display C compiler flags
    inputBinding:
      position: 101
      prefix: --cflags
  - id: fc
    type:
      - 'null'
      - boolean
    doc: Display the Fortran compiler used
    inputBinding:
      position: 101
      prefix: --fc
  - id: fflags
    type:
      - 'null'
      - boolean
    doc: Display Fortran compiler flags
    inputBinding:
      position: 101
      prefix: --fflags
  - id: flibs
    type:
      - 'null'
      - boolean
    doc: Display Fortran libraries required to link
    inputBinding:
      position: 101
      prefix: --flibs
  - id: has_f03
    type:
      - 'null'
      - boolean
    doc: Whether Fortran 2003 is supported
    inputBinding:
      position: 101
      prefix: --has-f03
  - id: has_f90
    type:
      - 'null'
      - boolean
    doc: Whether Fortran 90 is supported
    inputBinding:
      position: 101
      prefix: --has-f90
  - id: has_nc2
    type:
      - 'null'
      - boolean
    doc: Whether NetCDF-2 is supported
    inputBinding:
      position: 101
      prefix: --has-nc2
  - id: has_nc4
    type:
      - 'null'
      - boolean
    doc: Whether NetCDF-4 is supported
    inputBinding:
      position: 101
      prefix: --has-nc4
  - id: includedir
    type:
      - 'null'
      - boolean
    doc: Display the header installation directory
    inputBinding:
      position: 101
      prefix: --includedir
  - id: libdir
    type:
      - 'null'
      - boolean
    doc: Display the library installation directory
    inputBinding:
      position: 101
      prefix: --libdir
  - id: prefix
    type:
      - 'null'
      - boolean
    doc: Display the installation prefix
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_openmpi_5_0_7_nf-config.out
