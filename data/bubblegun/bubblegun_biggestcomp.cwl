cwlVersion: v1.2
class: CommandLineTool
baseCommand: BubbleGun
label: bubblegun_biggestcomp
doc: "Command for separating biggest component (BubbleGun biggestcomp).\n\nTool homepage: https://github.com/fawaz-dabbaghieh/bubble_gun"
arguments:
  - position: 2
    valueFrom: biggestcomp
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
  - id: path_big_comp
    type: string
    doc: Biggest component output path
    inputBinding:
      position: 3
outputs:
  - id: biggest_component
    type: File
    doc: Graph of the biggest component
    outputBinding:
      glob: $(inputs.path_big_comp)
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
