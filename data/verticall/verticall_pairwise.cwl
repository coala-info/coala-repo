cwlVersion: v1.2
class: CommandLineTool
baseCommand: verticall pairwise
label: verticall_pairwise
doc: "pairwise analysis of assemblies\n\nTool homepage: https://github.com/rrwick/Verticall"
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
  - id: existing_tsv
    type:
      - 'null'
      - File
    doc: "Verticall will skip any assembly pairs present in\nthis existing TSV file"
    inputBinding:
      position: 101
      prefix: --existing_tsv
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
  - id: index_only
    type:
      - 'null'
      - boolean
    doc: Quit after building indices
    inputBinding:
      position: 101
      prefix: --index_only
  - id: index_options
    type:
      - 'null'
      - string
    doc: Minimap2 options for assembly indexing
    default: -k15 -w10
    inputBinding:
      position: 101
      prefix: --index_options
  - id: part
    type:
      - 'null'
      - string
    doc: "Fraction of the data to analyse (for\nparallelisation"
    default: 1/1
    inputBinding:
      position: 101
      prefix: --part
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference assembly in FASTA format
    inputBinding:
      position: 101
      prefix: --reference
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
  - id: skip_check
    type:
      - 'null'
      - boolean
    doc: "Do not carry out the assembly check for duplicate\ncontig names and ambiguous
      bases"
    inputBinding:
      position: 101
      prefix: --skip_check
  - id: smoothing_factor
    type:
      - 'null'
      - float
    doc: "Degree to which the distance distribution is\nsmoothed"
    default: 0.8
    inputBinding:
      position: 101
      prefix: --smoothing_factor
  - id: threads
    type:
      - 'null'
      - int
    doc: CPU threads for parallel processing
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output more detail to stderr for debugging
    inputBinding:
      position: 101
      prefix: --verbose
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
  - id: out_file
    type: File
    doc: Filename of TSV output
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
