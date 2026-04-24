cwlVersion: v1.2
class: CommandLineTool
baseCommand: patchwork
label: patchwork
doc: "Processes dot files to generate graph visualizations, with options for various
  layout engines and configurations.\n\nTool homepage: https://github.com/ssbc/patchwork"
inputs:
  - id: dot_files
    type:
      type: array
      items: File
    doc: Input dot files
    inputBinding:
      position: 1
  - id: auto_output_filename
    type:
      - 'null'
      - boolean
    doc: Automatically generate an output filename based on the input filename 
      with a .'format' appended. (Causes all -ofile options to be ignored.)
    inputBinding:
      position: 102
      prefix: -O
  - id: configure_plugins
    type:
      - 'null'
      - boolean
    doc: Configure plugins (Writes $prefix/lib/graphviz/config with available 
      plugin information. Needs write privilege.)
    inputBinding:
      position: 102
      prefix: -c
  - id: dont_use_grid
    type:
      - 'null'
      - boolean
    doc: Don't use grid
    inputBinding:
      position: 102
      prefix: -Lg
  - id: external_library
    type:
      - 'null'
      - string
    doc: Use external library 'v'
    inputBinding:
      position: 102
      prefix: -l
  - id: generate_plugin_graph
    type:
      - 'null'
      - boolean
    doc: Internally generate a graph of the current plugins.
    inputBinding:
      position: 102
      prefix: -P
  - id: invert_y_coordinate
    type:
      - 'null'
      - boolean
    doc: Invert y coordinate in output
    inputBinding:
      position: 102
      prefix: -y
  - id: layout_engine
    type:
      - 'null'
      - string
    doc: Set layout engine to 'v' (overrides default based on command name)
    inputBinding:
      position: 102
      prefix: -K
  - id: memory_test
    type:
      - 'null'
      - boolean
    doc: Memory test (Observe no growth with top. Kill when done.)
    inputBinding:
      position: 102
      prefix: -m
  - id: memory_test_iterations
    type:
      - 'null'
      - int
    doc: Memory test - v iterations.
    inputBinding:
      position: 102
      prefix: -m
  - id: message_suppression_level
    type:
      - 'null'
      - int
    doc: Set level of message suppression
    inputBinding:
      position: 102
      prefix: -q
  - id: no_layout_mode
    type:
      - 'null'
      - int
    doc: No layout mode 'v'
    inputBinding:
      position: 102
      prefix: -n
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: Set number of iterations to i
    inputBinding:
      position: 102
      prefix: -Ln
  - id: output_format
    type:
      - 'null'
      - string
    doc: Set output format to 'v'
    inputBinding:
      position: 102
      prefix: -T
  - id: overlap_expansion_factor
    type:
      - 'null'
      - float
    doc: Set overlap expansion factor to v
    inputBinding:
      position: 102
      prefix: -LC
  - id: reduce_graph
    type:
      - 'null'
      - boolean
    doc: Reduce graph
    inputBinding:
      position: 102
      prefix: -x
  - id: scale_input_by
    type:
      - 'null'
      - float
    doc: Scale input by 'v'
    inputBinding:
      position: 102
      prefix: -s
  - id: set_edge_attribute
    type:
      - 'null'
      - string
    doc: Set edge attribute 'name' to 'val'
    inputBinding:
      position: 102
      prefix: -E
  - id: set_graph_attribute
    type:
      - 'null'
      - string
    doc: Set graph attribute 'name' to 'val'
    inputBinding:
      position: 102
      prefix: -G
  - id: set_node_attribute
    type:
      - 'null'
      - string
    doc: Set node attribute 'name' to 'val'
    inputBinding:
      position: 102
      prefix: -N
  - id: temperature
    type:
      - 'null'
      - float
    doc: Set temperature (temperature factor) to v
    inputBinding:
      position: 102
      prefix: -LT
  - id: unscaled_factor
    type:
      - 'null'
      - int
    doc: Set unscaled factor to i
    inputBinding:
      position: 102
      prefix: -LU
  - id: use_old_attractive_force
    type:
      - 'null'
      - boolean
    doc: Use old attractive force
    inputBinding:
      position: 102
      prefix: -LO
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to 'file'
    outputBinding:
      glob: $(inputs.output_file)
