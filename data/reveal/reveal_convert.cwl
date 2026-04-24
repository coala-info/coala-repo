cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal convert
label: reveal_convert
doc: "Convert gfa graph to gml.\n\nTool homepage: https://github.com/hakimel/reveal.js"
inputs:
  - id: graphs
    type:
      - 'null'
      - type: array
        items: File
    doc: The gfa graph to convert to gml.
    inputBinding:
      position: 1
  - id: gfa
    type:
      - 'null'
      - boolean
    doc: Rewrite gfa file.
    inputBinding:
      position: 102
      prefix: --gfa
  - id: gml_max
    type:
      - 'null'
      - int
    doc: Max number of nodes per graph in gml output.
    inputBinding:
      position: 102
      prefix: --gml-max
  - id: max_samples
    type:
      - 'null'
      - int
    doc: Only align nodes that have maximally this many samples
    inputBinding:
      position: 102
      prefix: -x
  - id: min_samples
    type:
      - 'null'
      - int
    doc: Only align nodes that occcur in this many samples
    inputBinding:
      position: 102
      prefix: -n
  - id: partition
    type:
      - 'null'
      - boolean
    doc: Output graph as multiple subgraphs if possible.
    inputBinding:
      position: 102
      prefix: --partition
  - id: target_sample
    type:
      - 'null'
      - string
    doc: Only align nodes in which this sample occurs.
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
stdout: reveal_convert.out
