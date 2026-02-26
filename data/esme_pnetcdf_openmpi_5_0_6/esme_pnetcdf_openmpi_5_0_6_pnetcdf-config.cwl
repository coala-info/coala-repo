cwlVersion: v1.2
class: CommandLineTool
baseCommand: pnetcdf-config
label: esme_pnetcdf_openmpi_5_0_6_pnetcdf-config
doc: "is a utility program to display the build and installation information of the
  PnetCDF library.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs:
  - id: adios
    type:
      - 'null'
      - boolean
    doc: Whether ADIOS support is enabled or disabled
    inputBinding:
      position: 101
      prefix: --adios
  - id: all
    type:
      - 'null'
      - boolean
    doc: display all options
    inputBinding:
      position: 101
      prefix: --all
  - id: burst_buffering
    type:
      - 'null'
      - boolean
    doc: Whether burst buffer driver is built or not
    inputBinding:
      position: 101
      prefix: --burst-buffering
  - id: c++
    type:
      - 'null'
      - boolean
    doc: C++ compiler used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --c++
  - id: cc
    type:
      - 'null'
      - boolean
    doc: C compiler used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --cc
  - id: cflags
    type:
      - 'null'
      - boolean
    doc: C compiler flags used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --cflags
  - id: config_date
    type:
      - 'null'
      - boolean
    doc: Date of PnetCDF library was configured
    inputBinding:
      position: 101
      prefix: --config-date
  - id: cppflags
    type:
      - 'null'
      - boolean
    doc: C pre-processor flags used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --cppflags
  - id: cxxflags
    type:
      - 'null'
      - boolean
    doc: C++ compiler flags used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --cxxflags
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Whether PnetCDF is built with debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: erange_fill
    type:
      - 'null'
      - boolean
    doc: Whether using fill values for NC_ERANGE error
    inputBinding:
      position: 101
      prefix: --erange-fill
  - id: f77
    type:
      - 'null'
      - boolean
    doc: Fortran 77 compiler used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --f77
  - id: fc
    type:
      - 'null'
      - boolean
    doc: Fortran 9x compiler used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --fc
  - id: fcflags
    type:
      - 'null'
      - boolean
    doc: Fortran 9x compiler flags used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --fcflags
  - id: fflags
    type:
      - 'null'
      - boolean
    doc: Fortran 77 compiler flags used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --fflags
  - id: fppflags
    type:
      - 'null'
      - boolean
    doc: Fortran pre-processor flags used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --fppflags
  - id: has_c++
    type:
      - 'null'
      - boolean
    doc: whether C++ API is installed
    inputBinding:
      position: 101
      prefix: --has-c++
  - id: has_fortran
    type:
      - 'null'
      - boolean
    doc: whether Fortran API is installed
    inputBinding:
      position: 101
      prefix: --has-fortran
  - id: in_place_swap
    type:
      - 'null'
      - boolean
    doc: Whether using buffer in-place Endianness byte swap
    inputBinding:
      position: 101
      prefix: --in-place-swap
  - id: includedir
    type:
      - 'null'
      - boolean
    doc: Installation directory containing header files
    inputBinding:
      position: 101
      prefix: --includedir
  - id: ldflags
    type:
      - 'null'
      - boolean
    doc: Linker flags used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --ldflags
  - id: libdir
    type:
      - 'null'
      - boolean
    doc: Installation directory containing library files
    inputBinding:
      position: 101
      prefix: --libdir
  - id: libs
    type:
      - 'null'
      - boolean
    doc: Extra libraries used to build PnetCDF
    inputBinding:
      position: 101
      prefix: --libs
  - id: netcdf4
    type:
      - 'null'
      - boolean
    doc: Whether NetCDF-4 support is enabled or disabled
    inputBinding:
      position: 101
      prefix: --netcdf4
  - id: null_byte_header_padding
    type:
      - 'null'
      - boolean
    doc: Whether to check null-byte padding in header
    inputBinding:
      position: 101
      prefix: --null-byte-header-padding
  - id: prefix
    type:
      - 'null'
      - boolean
    doc: Installation directory
    inputBinding:
      position: 101
      prefix: --prefix
  - id: profiling
    type:
      - 'null'
      - boolean
    doc: Whether internal profiling is enabled or not
    inputBinding:
      position: 101
      prefix: --profiling
  - id: relax_coord_bound
    type:
      - 'null'
      - boolean
    doc: Whether using a relaxed coordinate boundary check
    inputBinding:
      position: 101
      prefix: --relax-coord-bound
  - id: release_date
    type:
      - 'null'
      - boolean
    doc: Date of PnetCDF source was released
    inputBinding:
      position: 101
      prefix: --release-date
  - id: subfiling
    type:
      - 'null'
      - boolean
    doc: Whether subfiling is enabled or disabled
    inputBinding:
      position: 101
      prefix: --subfiling
  - id: thread_safe
    type:
      - 'null'
      - boolean
    doc: Whether thread-safe capability is enabled or not
    inputBinding:
      position: 101
      prefix: --thread-safe
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/esme_pnetcdf_openmpi_5_0_6:1.14.0--h1080dc9_0
stdout: esme_pnetcdf_openmpi_5_0_6_pnetcdf-config.out
