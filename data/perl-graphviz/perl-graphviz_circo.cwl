cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - /usr/local/bin/circo
label: perl-graphviz_circo
doc: Graphviz circo graph layout engine
inputs:
  - id: dot_files
    type:
      type: array
      items: File
    doc: Input dot files
    inputBinding:
      position: 1
  - id: graph_attribute
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -G
          separate: true
    doc: Set graph attribute 'name' to 'val'
    inputBinding:
      position: 102
  - id: node_attribute
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -N
          separate: true
    doc: Set node attribute 'name' to 'val'
    inputBinding:
      position: 102
  - id: edge_attribute
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -E
          separate: true
    doc: Set edge attribute 'name' to 'val'
    inputBinding:
      position: 102
  - id: output_format
    type:
      - 'null'
      - string
    doc: Set output format to 'v'
    inputBinding:
      position: 102
      prefix: -T
  - id: layout_engine
    type:
      - 'null'
      - string
    doc: Set layout engine to 'v' (overrides default based on command name)
    inputBinding:
      position: 102
      prefix: -K
  - id: library
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -l
          separate: true
    doc: Use external library 'v'
    inputBinding:
      position: 102
  - id: output_file
    type:
      - 'null'
      - string
    doc: Write output to 'file'
    inputBinding:
      position: 102
      prefix: -o
  - id: auto_output_name
    type:
      - 'null'
      - boolean
    doc: Automatically generate an output filename based on the input filename 
      with a .'format' appended. (Causes all -ofile options to be ignored.)
    inputBinding:
      position: 102
      prefix: -O
  - id: plugins_graph
    type:
      - 'null'
      - boolean
    doc: Internally generate a graph of the current plugins.
    inputBinding:
      position: 102
      prefix: -P
  - id: suppress_messages
    type:
      - 'null'
      - int
    doc: Set level of message suppression (=1)
    inputBinding:
      position: 102
      prefix: -q
  - id: scale
    type:
      - 'null'
      - float
    doc: Scale input by 'v' (=72)
    inputBinding:
      position: 102
      prefix: -s
  - id: invert_y
    type:
      - 'null'
      - boolean
    doc: Invert y coordinate in output
    inputBinding:
      position: 102
      prefix: -y
  - id: no_layout_mode
    type:
      - 'null'
      - int
    doc: No layout mode 'v' (=1)
    inputBinding:
      position: 102
      prefix: -n
  - id: reduce_graph
    type:
      - 'null'
      - boolean
    doc: Reduce graph
    inputBinding:
      position: 102
      prefix: -x
  - id: no_grid
    type:
      - 'null'
      - boolean
    doc: Don't use grid
    inputBinding:
      position: 102
      prefix: -Lg
  - id: old_attractive_force
    type:
      - 'null'
      - boolean
    doc: Use old attractive force
    inputBinding:
      position: 102
      prefix: -LO
  - id: iterations
    type:
      - 'null'
      - int
    doc: Set number of iterations to i
    inputBinding:
      position: 102
      prefix: -Ln
  - id: unscaled_factor
    type:
      - 'null'
      - int
    doc: Set unscaled factor to i
    inputBinding:
      position: 102
      prefix: -LU
  - id: overlap_expansion_factor
    type:
      - 'null'
      - float
    doc: Set overlap expansion factor to v
    inputBinding:
      position: 102
      prefix: -LC
  - id: temperature
    type:
      - 'null'
      - string
    doc: Set temperature (temperature factor) to v
    inputBinding:
      position: 102
      prefix: -LT
  - id: configure_plugins
    type:
      - 'null'
      - boolean
    doc: Configure plugins (Writes $prefix/lib/graphviz/config with available 
      plugin information. Needs write privilege.)
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Write output to 'file'
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-graphviz:2.26--pl5321h46c88eb_0
s:url: https://metacpan.org/pod/GraphViz
$namespaces:
  s: https://schema.org/
