cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal subgraph
label: reveal_subgraph
doc: "Extract subgraph from gfa by specified node ids.\n\nTool homepage: https://github.com/hakimel/reveal.js"
inputs:
  - id: inputfiles
    type:
      type: array
      items: File
    doc: The gfa graph followed by node ids that make up the subgraph.
    inputBinding:
      position: 1
  - id: gml
    type:
      - 'null'
      - boolean
    doc: Produce a gml graph instead of gfa.
    inputBinding:
      position: 102
      prefix: --gml
  - id: outfile_path
    type: string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Prefix of the file to which subgraph will be written.
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
