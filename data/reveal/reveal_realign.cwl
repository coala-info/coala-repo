cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal realign
label: reveal_realign
doc: "Realign between two nodes in the graph.\n\nTool homepage: https://github.com/hakimel/reveal.js"
inputs:
  - id: graph
    type: File
    doc: Graph in gfa format for which a bubble should be realigned.
    inputBinding:
      position: 1
  - id: source
    type:
      - 'null'
      - string
    doc: Source node.
    inputBinding:
      position: 2
  - id: sink
    type:
      - 'null'
      - string
    doc: Sink node.
    inputBinding:
      position: 3
  - id: all
    type:
      - 'null'
      - boolean
    doc: Trigger realignment for all complex bubbles.
    inputBinding:
      position: 104
      prefix: --all
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum length of the cumulative sum of all paths that run through the 
      complex bubble.
    inputBinding:
      position: 104
      prefix: --maxlen
  - id: max_size
    type:
      - 'null'
      - int
    doc: Maximum allowed number of nodes that are contained in a complex bubble.
    inputBinding:
      position: 104
      prefix: --maxsize
  - id: min_length
    type:
      - 'null'
      - int
    doc: Min length of an exact match
    inputBinding:
      position: 104
      prefix: -m
  - id: min_n
    type:
      - 'null'
      - int
    doc: Only align graph on exact matches that occur in at least this many 
      samples.
    inputBinding:
      position: 104
      prefix: -n
  - id: min_score
    type:
      - 'null'
      - int
    doc: Min score of an exact match (default 0), exact maches are scored by 
      their length and penalized by the indel they create with respect to 
      previously accepted exact matches.
    inputBinding:
      position: 104
      prefix: -c
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: File to which realigned graph is to be written.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
