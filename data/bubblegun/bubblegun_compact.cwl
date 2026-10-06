cwlVersion: v1.2
class: CommandLineTool
baseCommand: BubbleGun
label: bubblegun_compact
doc: "Command for compacting graphs (BubbleGun compact).\n\nTool homepage: https://github.com/fawaz-dabbaghieh/bubble_gun"
arguments:
  - position: 2
    valueFrom: compact
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
  - id: path_compacted
    type: string
    doc: Compacted graph output path
    inputBinding:
      position: 3
outputs:
  - id: compacted_graph
    type: File
    doc: Compacted graph
    outputBinding:
      glob: $(inputs.path_compacted)
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
