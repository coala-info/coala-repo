cwlVersion: v1.2
class: CommandLineTool
baseCommand: BubbleGun
label: bubblegun_BubbleGun
doc: "Find Bubble Chains.\n\nTool homepage: https://github.com/fawaz-dabbaghieh/bubble_gun"
inputs:
  - id: graph_path
    type:
      - 'null'
      - File
    doc: graph file path (GFA or VG)
    inputBinding:
      position: 101
      prefix: --in_graph
  - id: log_file
    type:
      - 'null'
      - File
    doc: The name/path of the log file.
    default: log.log
    inputBinding:
      position: 101
      prefix: --log_file
  - id: log_level
    type:
      - 'null'
      - string
    doc: The logging level [DEBUG, INFO, WARNING, ERROR, CRITICAL]
    inputBinding:
      position: 101
      prefix: --log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bubblegun:1.2.0--pyhdfd78af_0
stdout: bubblegun_BubbleGun.out
