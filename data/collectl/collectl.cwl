cwlVersion: v1.2
class: CommandLineTool
baseCommand: collectl
label: collectl
doc: "A performance monitoring tool that collects data for various system subsystems.\n
  \nTool homepage: https://github.com/sharkcz/collectl"
inputs:
  - id: count
    type:
      - 'null'
      - int
    doc: collect this number of samples and exit
    inputBinding:
      position: 101
      prefix: --count
  - id: interval
    type:
      - 'null'
      - int
    doc: collection interval in seconds
    inputBinding:
      position: 101
      prefix: --interval
  - id: options
    type:
      - 'null'
      - string
    doc: misc formatting options (e.g., d|D for date, T for time, z for no compression)
    inputBinding:
      position: 101
      prefix: --options
  - id: playback
    type:
      - 'null'
      - File
    doc: playback results from 'file'
    inputBinding:
      position: 101
      prefix: --playback
  - id: plot
    type:
      - 'null'
      - boolean
    doc: generate output in 'plot' format
    inputBinding:
      position: 101
      prefix: --plot
  - id: show_col_headers
    type:
      - 'null'
      - boolean
    doc: show column headers that 'would be' generated
    inputBinding:
      position: 101
      prefix: --showcolheaders
  - id: show_defs
    type:
      - 'null'
      - boolean
    doc: print operational defaults
    inputBinding:
      position: 101
      prefix: --showdefs
  - id: show_header
    type:
      - 'null'
      - boolean
    doc: show file header that 'would be' generated
    inputBinding:
      position: 101
      prefix: --showheader
  - id: show_options
    type:
      - 'null'
      - boolean
    doc: show all the options
    inputBinding:
      position: 101
      prefix: --showoptions
  - id: show_root_slabs
    type:
      - 'null'
      - boolean
    doc: same as --showslabaliases but use 'root' names
    inputBinding:
      position: 101
      prefix: --showrootslabs
  - id: show_slab_aliases
    type:
      - 'null'
      - boolean
    doc: for SLUB allocator, show non-root aliases
    inputBinding:
      position: 101
      prefix: --showslabaliases
  - id: show_subopts
    type:
      - 'null'
      - boolean
    doc: show all subsystem specific options
    inputBinding:
      position: 101
      prefix: --showsubopts
  - id: show_subsys
    type:
      - 'null'
      - boolean
    doc: show all the subsystems
    inputBinding:
      position: 101
      prefix: --showsubsys
  - id: show_topopts
    type:
      - 'null'
      - boolean
    doc: show --top options
    inputBinding:
      position: 101
      prefix: --showtopopts
  - id: subsys
    type:
      - 'null'
      - string
    doc: specify one or more subsystems
    inputBinding:
      position: 101
      prefix: --subsys
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display output in verbose format
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: name of directory/file to write to
    outputBinding:
      glob: $(inputs.filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/collectl:4.3.20.2--pl5321h05cac1d_0
