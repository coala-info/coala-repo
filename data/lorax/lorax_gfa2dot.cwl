cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorax
  - gfa2dot
label: lorax_gfa2dot
doc: "Convert a pan-genome graph (GFA) to dot (graphviz) format.\n\nTool homepage: https://github.com/tobiasrausch/lorax"
inputs:
  - id: pangenome_gfa
    type: File
    doc: pan-genome graph in GFA format (gzipped or plain)
    inputBinding:
      position: 1
  - id: radius
    type:
      - 'null'
      - int
    doc: radius around selected node [default 1]
    inputBinding:
      position: 101
      prefix: --radius
  - id: component
    type:
      - 'null'
      - int
    doc: select a component of the graph [default 0]
    inputBinding:
      position: 101
      prefix: --component
  - id: segment
    type:
      - 'null'
      - string
    doc: segment to plot (all - all segments, comp - connected component of the graph) [default all]
    inputBinding:
      position: 101
      prefix: --segment
  - id: outfile_path
    type: string
    doc: output dot file
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output dot file
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
