cwlVersion: v1.2
class: CommandLineTool
baseCommand: teloscope
label: teloscope
doc: "teloscope [commands]\n\nTool homepage: https://github.com/vgl-hub/teloscope"
inputs:
  - id: canonical
    type:
      - 'null'
      - string
    doc: Set canonical pattern.
    default: TTAGGG
    inputBinding:
      position: 101
      prefix: --canonical
  - id: cmd
    type:
      - 'null'
      - boolean
    doc: Print command line.
    inputBinding:
      position: 101
      prefix: --cmd
  - id: edit_distance
    type:
      - 'null'
      - int
    doc: Set edit distance for pattern matching (0-2).
    default: 0
    inputBinding:
      position: 101
      prefix: --edit-distance
  - id: input_sequence
    type: File
    doc: Initiate tool with fasta file.
    inputBinding:
      position: 101
      prefix: --input-sequence
  - id: max_block_distance
    type:
      - 'null'
      - int
    doc: Set maximum block distance for extension.
    default: 200
    inputBinding:
      position: 101
      prefix: --max-block-distance
  - id: max_match_distance
    type:
      - 'null'
      - int
    doc: Set maximum distance for merging matches.
    default: 50
    inputBinding:
      position: 101
      prefix: --max-match-distance
  - id: min_block_density
    type:
      - 'null'
      - float
    doc: Set minimum block density.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --min-block-density
  - id: min_block_length
    type:
      - 'null'
      - int
    doc: Set minimum block length.
    default: 500
    inputBinding:
      position: 101
      prefix: --min-block-length
  - id: out_entropy
    type:
      - 'null'
      - boolean
    doc: Output Shannon entropy for each window.
    default: false
    inputBinding:
      position: 101
      prefix: --out-entropy
  - id: out_gc
    type:
      - 'null'
      - boolean
    doc: Output GC content for each window.
    default: false
    inputBinding:
      position: 101
      prefix: --out-gc
  - id: out_its
    type:
      - 'null'
      - boolean
    doc: Output assembly interstitial telomere (ITSs) regions.
    default: false
    inputBinding:
      position: 101
      prefix: --out-its
  - id: out_matches
    type:
      - 'null'
      - boolean
    doc: Output all canonical and terminal non-canonical matches.
    default: false
    inputBinding:
      position: 101
      prefix: --out-matches
  - id: out_win_repeats
    type:
      - 'null'
      - boolean
    doc: Output canonical/noncanonical repeats and density by window.
    default: false
    inputBinding:
      position: 101
      prefix: --out-win-repeats
  - id: patterns
    type:
      - 'null'
      - string
    doc: Set patterns to explore, separate them by commas
    default: TTAGGG
    inputBinding:
      position: 101
      prefix: --patterns
  - id: step
    type:
      - 'null'
      - int
    doc: Set sliding window step.
    default: 500
    inputBinding:
      position: 101
      prefix: --step
  - id: terminal_limit
    type:
      - 'null'
      - int
    doc: Set terminal limit for exploring telomere variant regions (TVRs).
    default: 50000
    inputBinding:
      position: 101
      prefix: --terminal-limit
  - id: threads
    type:
      - 'null'
      - int
    doc: Set maximum number of threads.
    default: max. available
    inputBinding:
      position: 101
      prefix: --threads
  - id: ultra_fast
    type:
      - 'null'
      - boolean
    doc: Ultra-fast mode. Only scans terminal telomeres at contig ends.
    default: true
    inputBinding:
      position: 101
      prefix: --ultra-fast
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: Set sliding window size.
    default: 1000
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Set output route.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/teloscope:0.1.3--h35c04b2_0
