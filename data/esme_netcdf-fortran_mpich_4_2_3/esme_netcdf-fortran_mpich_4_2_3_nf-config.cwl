cwlVersion: v1.2
class: CommandLineTool
baseCommand: nf-config
label: esme_netcdf-fortran_mpich_4_2_3_nf-config
doc: "Display configuration information for the NetCDF-Fortran library.\n\nTool homepage:
  http://www.unidata.ucar.edu/software/netcdf/"
inputs:
  - id: all_options
    type:
      - 'null'
      - boolean
    doc: display all options
    inputBinding:
      position: 101
      prefix: --all
  - id: c_compiler
    type:
      - 'null'
      - boolean
    doc: C compiler
    inputBinding:
      position: 101
      prefix: --cc
  - id: c_flags
    type:
      - 'null'
      - boolean
    doc: pre-processor and compiler flags
    inputBinding:
      position: 101
      prefix: --cflags
  - id: fortran_compiler
    type:
      - 'null'
      - boolean
    doc: Fortran compiler
    inputBinding:
      position: 101
      prefix: --fc
  - id: fortran_flags
    type:
      - 'null'
      - boolean
    doc: flags needed to compile a Fortran program
    inputBinding:
      position: 101
      prefix: --fflags
  - id: fortran_libraries
    type:
      - 'null'
      - boolean
    doc: libraries needed to link a Fortran program
    inputBinding:
      position: 101
      prefix: --flibs
  - id: has_dap
    type:
      - 'null'
      - boolean
    doc: whether OPeNDAP is enabled in this build
    inputBinding:
      position: 101
      prefix: --has-dap
  - id: has_f03
    type:
      - 'null'
      - boolean
    doc: whether Fortran 2003 API is enabled in this build
    inputBinding:
      position: 101
      prefix: --has-f03
  - id: has_f90
    type:
      - 'null'
      - boolean
    doc: whether Fortran 90 API is enabled in this build
    inputBinding:
      position: 101
      prefix: --has-f90
  - id: has_nc2
    type:
      - 'null'
      - boolean
    doc: whether NetCDF-2 API is enabled
    inputBinding:
      position: 101
      prefix: --has-nc2
  - id: has_nc4
    type:
      - 'null'
      - boolean
    doc: whether NetCDF-4/HDF-5 is enabled in this build
    inputBinding:
      position: 101
      prefix: --has-nc4
  - id: include_directory
    type:
      - 'null'
      - boolean
    doc: Include directory
    inputBinding:
      position: 101
      prefix: --includedir
  - id: install_prefix
    type:
      - 'null'
      - boolean
    doc: Install prefix
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_mpich_4_2_3_nf-config.out
