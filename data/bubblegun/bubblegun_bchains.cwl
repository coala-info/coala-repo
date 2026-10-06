cwlVersion: v1.2
class: CommandLineTool
baseCommand: BubbleGun
label: bubblegun_bchains
doc: "Command for detecting bubble chains (BubbleGun bchains).\n\nTool homepage: https://github.com/fawaz-dabbaghieh/bubble_gun"
arguments:
  - position: 2
    valueFrom: bchains
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
  - id: out_json
    type:
      - 'null'
      - string
    doc: Outputs Bubbles, Superbubbles, and Chains as a JSON file
    inputBinding:
      position: 3
      prefix: --bubble_json
  - id: only_simple
    type:
      - 'null'
      - boolean
    doc: If used then only simple bubbles are detected
    inputBinding:
      position: 3
      prefix: --only_simple
  - id: only_super
    type:
      - 'null'
      - boolean
    doc: If used then only superbubbles are detected
    inputBinding:
      position: 3
      prefix: --only_super
  - id: save_memory
    type:
      - 'null'
      - boolean
    doc: Identifies bubble chain with less memory. No statistics outputted
    inputBinding:
      position: 3
      prefix: --save_memory
  - id: chains_gfa
    type:
      - 'null'
      - string
    doc: Output only bubble chains as a GFA file
    inputBinding:
      position: 3
      prefix: --chains_gfa
  - id: fasta
    type:
      - 'null'
      - string
    doc: Outputs the bubble branches as fasta file (doesn't work with memory saving)
    inputBinding:
      position: 3
      prefix: --fasta
  - id: out_haplos
    type:
      - 'null'
      - boolean
    doc: output randomly two haplotypes for each chain (doesn't work with memory
      saving); needs --only_simple
    inputBinding:
      position: 3
      prefix: --out_haplos
outputs:
  - id: stats
    type: stdout
    doc: Bubble and chain statistics printed to standard output
  - id: bubble_json
    type:
      - 'null'
      - File
    doc: Bubbles, superbubbles and chains as JSON
    outputBinding:
      glob: $(inputs.out_json)
  - id: chains_gfa_file
    type:
      - 'null'
      - File
    doc: Bubble chains as GFA
    outputBinding:
      glob: $(inputs.chains_gfa)
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Bubble branches as FASTA
    outputBinding:
      glob: $(inputs.fasta)
  - id: haplotypes
    type: File[]
    doc: Two random haplotypes of each chain (haplotype1.fasta, haplotype2.fasta)
    outputBinding:
      glob: haplotype*.fasta
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
stdout: bubblegun_bchains.out
