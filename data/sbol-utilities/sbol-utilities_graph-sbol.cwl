cwlVersion: v1.2
class: CommandLineTool
baseCommand: graph-sbol
label: sbol-utilities_graph-sbol
doc: "Reads an SBOL file and renders a graph of it with Graphviz. The output is written beside the input as <input name before the first dot>.<format>.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs:
  - id: in_file
    type: File
    doc: Input SBOL file.
    inputBinding:
      position: 1
      prefix: --input
      valueFrom: $(self.basename)
  - id: format
    type:
      - 'null'
      - string
    doc: Final file format to produce graph in (default pdf).
    inputBinding:
      position: 2
      prefix: --format
  - id: view
    type:
      - 'null'
      - boolean
    doc: Without this flag the tool tries to open the generated file in a viewer. Use this flag to avoid that.
    inputBinding:
      position: 3
      prefix: --view
outputs:
  - id: graph_file
    type:
      - 'null'
      - File
    doc: Rendered graph file.
    outputBinding:
      glob: $(inputs.in_file.basename.split('.')[0]).$(inputs.format || 'pdf')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.in_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
