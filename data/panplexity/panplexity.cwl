cwlVersion: v1.2
class: CommandLineTool
baseCommand: panplexity
label: panplexity
doc: "A tool for calculating complexity measures (linguistic or entropy) on GFA files
  and identifying low-complexity regions.\n\nTool homepage: https://github.com/AndreaGuarracino/panplexity"
inputs:
  - id: complexity
    type:
      - 'null'
      - string
    doc: 'Complexity measure type: "linguistic" or "entropy"'
    inputBinding:
      position: 101
      prefix: --complexity
  - id: distance
    type:
      - 'null'
      - int
    doc: Distance threshold for merging close ranges
    inputBinding:
      position: 101
      prefix: --distance
  - id: input_gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 101
      prefix: --input-gfa
  - id: iqr_multiplier
    type:
      - 'null'
      - float
    doc: 'IQR multiplier for automatic threshold (default: 1.5, use with threshold
      "auto")'
    inputBinding:
      position: 101
      prefix: --iqr-multiplier
  - id: k_mer
    type:
      - 'null'
      - int
    doc: K-mer size (used with linguistic complexity)
    inputBinding:
      position: 101
      prefix: --k-mer
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size for sliding window (used with entropy complexity)
    inputBinding:
      position: 101
      prefix: --step-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - string
    doc: Threshold for low-complexity regions (number or "auto")
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Verbosity level (0: errors only, 1: errors and info, 2: debug, 3: trace)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for complexity calculation
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: output_gfa
    type:
      - 'null'
      - File
    doc: Output annotated GFA file
    outputBinding:
      glob: $(inputs.output_gfa)
  - id: bed
    type:
      - 'null'
      - File
    doc: Output BED file with low-complexity ranges
    outputBinding:
      glob: $(inputs.bed)
  - id: csv
    type:
      - 'null'
      - File
    doc: Output CSV file for Bandage node coloring (Node,Colour format)
    outputBinding:
      glob: $(inputs.csv)
  - id: mask
    type:
      - 'null'
      - File
    doc: 'Output boolean mask file: 1 if node is not annotated, 0 if annotated'
    outputBinding:
      glob: $(inputs.mask)
  - id: weights
    type:
      - 'null'
      - File
    doc: 'Output weights file: node_id and its associated complexity/entropy weight'
    outputBinding:
      glob: $(inputs.weights)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panplexity:0.1.1--h3ab6199_0
