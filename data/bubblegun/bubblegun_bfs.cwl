cwlVersion: v1.2
class: CommandLineTool
baseCommand: BubbleGun
label: bubblegun_bfs
doc: "Command for separating neighborhood (BubbleGun bfs).\n\nTool homepage: https://github.com/fawaz-dabbaghieh/bubble_gun"
arguments:
  - position: 2
    valueFrom: bfs
inputs:
  - id: in_graph
    type: File
    doc: graph file path (GFA or VG)
    inputBinding:
      position: 1
      prefix: --in_graph
  - id: log_file
    type:
      - 'null'
      - string
    doc: 'The name/path of the log file. Default: log.log'
    inputBinding:
      position: 1
      prefix: --log_file
  - id: log_level
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
    doc: The logging level [DEBUG, INFO, WARNING, ERROR, CRITICAL]
    inputBinding:
      position: 1
      prefix: --log
  - id: start_nodes
    type: string[]
    doc: Give the starting node(s) for neighborhood extraction
    inputBinding:
      position: 3
      prefix: --start
  - id: neighborhood_size
    type: int
    doc: With -s --start option, size of neighborhood to extract
    inputBinding:
      position: 3
      prefix: --neighborhood_size
  - id: output_neighborhood
    type: string
    doc: Output neighborhood file
    inputBinding:
      position: 3
      prefix: --output_neighborhood
outputs:
  - id: neighborhood
    type: File
    doc: Neighborhood graph (GFA)
    outputBinding:
      glob: $(inputs.output_neighborhood)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: "$(inputs.log_file ? inputs.log_file : 'log.log')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bubblegun:1.2.0--pyhdfd78af_0
