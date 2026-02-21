cwlVersion: v1.2
class: CommandLineTool
baseCommand: circo
label: perl-graphviz_circo
doc: "circo draws graphs using a circular layout. It is part of the Graphviz visualization
  software suite.\n\nTool homepage: https://metacpan.org/pod/GraphViz"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input graph file in DOT format
    inputBinding:
      position: 1
  - id: layout_engine
    type:
      - 'null'
      - string
    doc: Specifies which default layout engine to use
    inputBinding:
      position: 102
      prefix: -K
  - id: output_format
    type:
      - 'null'
      - string
    doc: Set output language to one of the supported formats (e.g., pdf, svg, png,
      ps)
    inputBinding:
      position: 102
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-graphviz:2.26--pl5321h46c88eb_0
