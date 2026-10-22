cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtlay
label: smartdenovo_wtlay
doc: "WTLay: Layout of long reads using Best Overlap Graph (SMARTdenovo)\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: long_reads
    type:
      type: array
      items: File
      inputBinding:
        prefix: -i
    doc: "Long reads sequences file(s), +, *"
    inputBinding:
      position: 101
  - id: retained_region
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -b
    doc: "Long reads retained region, often from wtobt, +. Format: read_name\\toffset\\tlength\\toriginal_len"
    inputBinding:
      position: 101
  - id: overlap_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: -j
    doc: "Overlap file(s), +, *. Format: reads1\\t+/-\\tlen1\\tbeg1\\tend1\\treads2\\t+/-\\tlen2\\tbeg2\\tend2\\tscore"
    inputBinding:
      position: 101
  - id: min_matched_bases
    type:
      - 'null'
      - int
    doc: "Minimum alignment matched bases, [500]"
    inputBinding:
      position: 101
      prefix: -s
  - id: min_identity
    type:
      - 'null'
      - float
    doc: "Minimum alignment identity, [0.6]"
    inputBinding:
      position: 101
      prefix: -m
  - id: max_margin
    type:
      - 'null'
      - int
    doc: "Maximum margin of alignment, [100]"
    inputBinding:
      position: 101
      prefix: -w
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Force overwrite output file"
    inputBinding:
      position: 101
      prefix: -f
  - id: min_edge_coverage
    type:
      - 'null'
      - int
    doc: "Minimum estimated coverage of edge to be trusted, [1]"
    inputBinding:
      position: 101
      prefix: -c
  - id: matches_as_score
    type:
      - 'null'
      - boolean
    doc: "Use number of matches as alignment score"
    inputBinding:
      position: 101
      prefix: -R
  - id: best_score_cutoff
    type:
      - 'null'
      - float
    doc: "Best score cutoff: best overlap MUST have alignment score >= <-r> * read's best score, [0.95]"
    inputBinding:
      position: 101
      prefix: -r
  - id: min_unitig_coverage
    type:
      - 'null'
      - float
    doc: "Minimum coverage for similar unitig detection, [0.4]"
    inputBinding:
      position: 101
      prefix: -q
  - id: min_layout_nodes
    type:
      - 'null'
      - int
    doc: "Min nodes of a layout to be output as independent unitig, [4]"
    inputBinding:
      position: 101
      prefix: -u
  - id: max_bubble_step
    type:
      - 'null'
      - int
    doc: "Maximum step in tracing bubbles, [20]"
    inputBinding:
      position: 101
      prefix: -B
  - id: variance_threshold
    type:
      - 'null'
      - float
    doc: "Variance threshold of (alignment score / overlap) between true and false overlaps, [0.50]"
    inputBinding:
      position: 101
      prefix: -S
  - id: debug_commands
    type:
      - 'null'
      - string
    doc: "Debug commands, [gCwgBgRURg]"
    inputBinding:
      position: 101
      prefix: -Q
  - id: output_path
    type: string
    doc: "Output file of layouts, *"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output
    type: File
    doc: "Layouts"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
