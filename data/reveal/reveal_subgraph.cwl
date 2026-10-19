cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reveal
  - subgraph
label: reveal_subgraph
doc: "Extract subgraph from gfa by specified node ids.\n\nTool homepage: https://github.com/jasperlinthorst/reveal"
inputs:
  - id: graph
    type: File
    doc: The gfa graph from which the subgraph is extracted.
    inputBinding:
      position: 1
  - id: node_ids
    type:
      type: array
      items: string
    doc: Node ids that make up the subgraph.
    inputBinding:
      position: 2
  - id: gml
    type:
      - 'null'
      - boolean
    doc: Produce a gml graph instead of gfa.
    inputBinding:
      position: 102
      prefix: --gml
  - id: outfile_path
    type: string?
    doc: Prefix of the file to which subgraph will be written.
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: outfile
    type:
      - 'null'
      - type: array
        items: File
    doc: Prefix of the file to which subgraph will be written.
    outputBinding:
      glob: $(inputs.outfile_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
