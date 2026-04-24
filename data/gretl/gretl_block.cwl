cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl_block
label: gretl_block
doc: "Statistics on pangenome blocks\n\nTool homepage: https://github.com/moinsebi/gretl"
inputs:
  - id: distance
    type:
      - 'null'
      - int
    doc: Distance till breaking the block [bp]
    inputBinding:
      position: 101
      prefix: --distance
  - id: graph
    type: File
    doc: GFA input file
    inputBinding:
      position: 101
      prefix: --graph
  - id: node_step
    type:
      - 'null'
      - int
    doc: Node step
    inputBinding:
      position: 101
      prefix: --node-step
  - id: node_window
    type:
      - 'null'
      - int
    doc: Window size (in nodes)
    inputBinding:
      position: 101
      prefix: --node-window
  - id: output_blocks
    type:
      - 'null'
      - boolean
    doc: Output all blocks in a this file
    inputBinding:
      position: 101
      prefix: --blocks
  - id: pansn
    type:
      - 'null'
      - string
    doc: PanSN-spec separator
    inputBinding:
      position: 101
      prefix: --pansn
  - id: sequence_step
    type:
      - 'null'
      - int
    doc: Sequence step
    inputBinding:
      position: 101
      prefix: --sequence-step
  - id: sequence_window
    type:
      - 'null'
      - int
    doc: Sequence window
    inputBinding:
      position: 101
      prefix: --sequence-window
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
