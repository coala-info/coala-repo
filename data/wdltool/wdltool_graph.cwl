cwlVersion: v1.2
class: CommandLineTool
baseCommand: wdltool graph
label: wdltool_graph
doc: "Generate a graphviz DOT representation of a WDL workflow.\n\nTool homepage:
  https://github.com/broadinstitute/wdltool"
inputs:
  - id: workflow_file
    type: File
    doc: Path to the WDL workflow file.
    inputBinding:
      position: 1
  - id: dot_only
    type:
      - 'null'
      - boolean
    doc: Only include the DOT representation, without any extra information.
    inputBinding:
      position: 102
      prefix: --dot-only
  - id: no_call_alias
    type:
      - 'null'
      - boolean
    doc: Do not use call aliases in the graph.
    inputBinding:
      position: 102
      prefix: --no-call-alias
  - id: no_collapse
    type:
      - 'null'
      - boolean
    doc: Do not collapse identical subgraphs.
    inputBinding:
      position: 102
      prefix: --no-collapse
  - id: no_inputs
    type:
      - 'null'
      - boolean
    doc: Do not include input parameters in the graph.
    inputBinding:
      position: 102
      prefix: --no-inputs
  - id: no_links
    type:
      - 'null'
      - boolean
    doc: Do not include links between tasks and calls.
    inputBinding:
      position: 102
      prefix: --no-links
  - id: no_outputs
    type:
      - 'null'
      - boolean
    doc: Do not include output parameters in the graph.
    inputBinding:
      position: 102
      prefix: --no-outputs
  - id: no_scatter
    type:
      - 'null'
      - boolean
    doc: Do not include scatter operations in the graph.
    inputBinding:
      position: 102
      prefix: --no-scatter
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output DOT file. If not specified, prints to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wdltool:0.14--1
