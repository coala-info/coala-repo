cwlVersion: v1.2
class: CommandLineTool
baseCommand: verticall view
label: verticall_view
doc: "view plots for a single assembly pair\n\nTool homepage: https://github.com/rrwick/Verticall"
inputs:
  - id: align_options
    type:
      - 'null'
      - string
    doc: Minimap2 options for assembly-to-assembly alignment
    default: -x asm20
    inputBinding:
      position: 101
      prefix: --align_options
  - id: allowed_overlap
    type:
      - 'null'
      - int
    doc: Allow this much overlap between alignments
    default: 100
    inputBinding:
      position: 101
      prefix: --allowed_overlap
  - id: ambiguous_colour
    type:
      - 'null'
      - string
    doc: Hex colour for ambiguous inheritance
    default: '#c9c9c9'
    inputBinding:
      position: 101
      prefix: --ambiguous_colour
  - id: horizontal_colour
    type:
      - 'null'
      - string
    doc: Hex colour for horizontal inheritance
    default: '#c47e7e'
    inputBinding:
      position: 101
      prefix: --horizontal_colour
  - id: ignore_indels
    type:
      - 'null'
      - boolean
    doc: Only use mismatches to determine distance
    inputBinding:
      position: 101
      prefix: --ignore_indels
  - id: in_dir
    type: Directory
    doc: Directory containing assemblies in FASTA format
    inputBinding:
      position: 101
      prefix: --in_dir
  - id: index_options
    type:
      - 'null'
      - string
    doc: Minimap2 options for assembly indexing
    default: -k15 -w10
    inputBinding:
      position: 101
      prefix: --index_options
  - id: names
    type: string
    doc: Two sample names (comma-delimited) to be viewed
    inputBinding:
      position: 101
      prefix: --names
  - id: result
    type:
      - 'null'
      - int
    doc: "Number of result to plot (used when there are\nmultiple possible results
      for the pair)"
    default: 1
    inputBinding:
      position: 101
      prefix: --result
  - id: secondary
    type:
      - 'null'
      - float
    doc: "Peaks with a mass of at least this fraction of the\nmost massive peak will
      be used to produce secondary\ndistances"
    default: 0.7
    inputBinding:
      position: 101
      prefix: --secondary
  - id: smoothing_factor
    type:
      - 'null'
      - float
    doc: "Degree to which the distance distribution is\nsmoothed"
    default: 0.8
    inputBinding:
      position: 101
      prefix: --smoothing_factor
  - id: sqrt_distance
    type:
      - 'null'
      - boolean
    doc: "Use a square-root transform on the genomic distance\naxis"
    inputBinding:
      position: 101
      prefix: --sqrt_distance
  - id: sqrt_mass
    type:
      - 'null'
      - boolean
    doc: "Use a square-root transform on the probability mass\naxis"
    inputBinding:
      position: 101
      prefix: --sqrt_mass
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output more detail to stderr for debugging
    inputBinding:
      position: 101
      prefix: --verbose
  - id: vertical_colour
    type:
      - 'null'
      - string
    doc: Hex colour for vertical inheritance
    default: '#4859a0'
    inputBinding:
      position: 101
      prefix: --vertical_colour
  - id: window_count
    type:
      - 'null'
      - int
    doc: "Aim to have at least this many comparison windows\nbetween assemblies"
    default: 50000
    inputBinding:
      position: 101
      prefix: --window_count
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Use this defined window size for all pairwise\ncomparisons"
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
stdout: verticall_view.out
