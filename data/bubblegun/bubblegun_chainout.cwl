cwlVersion: v1.2
class: CommandLineTool
baseCommand: BubbleGun
label: bubblegun_chainout
doc: "Outputs certain chain(s) given by their id as a GFA file (BubbleGun chainout).\n\nTool homepage: https://github.com/fawaz-dabbaghieh/bubble_gun"
arguments:
  - position: 2
    valueFrom: chainout
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
  - id: json_file
    type: File
    doc: The JSON file with bubble chains information
    inputBinding:
      position: 3
      prefix: --json_file
  - id: chain_ids
    type: string[]
    doc: Give the chain Id(s) to be outputted
    inputBinding:
      position: 3
      prefix: --chain_ids
  - id: output_chain
    type: string
    doc: Output path for the chains chosen
    inputBinding:
      position: 3
      prefix: --output_chain
outputs:
  - id: chains_gfa
    type: File
    doc: GFA of the chosen chains
    outputBinding:
      glob: $(inputs.output_chain)
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
