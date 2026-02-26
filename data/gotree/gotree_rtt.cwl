cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotree rtt
label: gotree_rtt
doc: "Compute Root To Tip regression.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    default: newick
    inputBinding:
      position: 101
      prefix: --format
  - id: image
    type:
      - 'null'
      - string
    doc: RTT plot image image output file
    default: none
    inputBinding:
      position: 101
      prefix: --image
  - id: image_height
    type:
      - 'null'
      - int
    doc: RTT plot image output heigh
    default: 4
    inputBinding:
      position: 101
      prefix: --image-height
  - id: image_width
    type:
      - 'null'
      - int
    doc: RTT plot image image output width
    default: 4
    inputBinding:
      position: 101
      prefix: --image-width
  - id: input
    type:
      - 'null'
      - string
    doc: Input tree(s) file
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: internal_nodes
    type:
      - 'null'
      - boolean
    doc: include internal nodes
    inputBinding:
      position: 101
      prefix: --internal-nodes
  - id: max_rate
    type:
      - 'null'
      - float
    doc: Mutation rate higher bound
    default: -1
    inputBinding:
      position: 101
      prefix: --max-rate
  - id: max_root_date
    type:
      - 'null'
      - float
    doc: Root date
    default: -1
    inputBinding:
      position: 101
      prefix: --max-root-date
  - id: min_rate
    type:
      - 'null'
      - float
    doc: Mutation rate lower bound
    default: -1
    inputBinding:
      position: 101
      prefix: --min-rate
  - id: min_root_date
    type:
      - 'null'
      - float
    doc: Root date
    default: -1
    inputBinding:
      position: 101
      prefix: --min-root-date
  - id: output
    type:
      - 'null'
      - string
    doc: RTT output file
    default: stdout
    inputBinding:
      position: 101
      prefix: --output
  - id: rate
    type:
      - 'null'
      - float
    doc: Mutation rate to display on the figure
    default: -1
    inputBinding:
      position: 101
      prefix: --rate
  - id: root_date
    type:
      - 'null'
      - float
    doc: Root date
    default: -1
    inputBinding:
      position: 101
      prefix: --root-date
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    default: -1
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_rtt.out
