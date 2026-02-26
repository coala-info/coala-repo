cwlVersion: v1.2
class: CommandLineTool
baseCommand: real
label: real
doc: "This is real version 0.0.31\nreal is distributed under version 3.0 of the GNU
  GENERAL PUBLIC LICENSE.\nMachine supports popcnt instruction.\nIgnoring argument
  --help\n\nTool homepage: https://nms.kcl.ac.uk/informatics/projects/real/?id=man"
inputs:
  - id: filter_level
    type:
      - 'null'
      - int
    doc: filtering level for equal hits 0-4
    default: 2
    inputBinding:
      position: 101
      prefix: --filter_level
  - id: gc_composition_bias
    type:
      - 'null'
      - float
    doc: composition bias
    default: 0.41
    inputBinding:
      position: 101
      prefix: --gc
  - id: gc_mutability_bias
    type:
      - 'null'
      - int
    doc: mutability bias of G&C
    default: 2
    inputBinding:
      position: 101
      prefix: --gcmut_bias
  - id: matching_threads
    type:
      - 'null'
      - int
    doc: number of matching threads
    default: 20
    inputBinding:
      position: 101
      prefix: -T
  - id: max_seed_errors
    type:
      - 'null'
      - int
    doc: maximum number of errors in seed
    default: 2
    inputBinding:
      position: 101
      prefix: -s
  - id: max_total_errors
    type:
      - 'null'
      - int
    doc: total maximum number of errors
    default: 5
    inputBinding:
      position: 101
      prefix: -e
  - id: memory_fraction
    type:
      - 'null'
      - float
    doc: fraction of physical memory to use
    default: 0.75
    inputBinding:
      position: 101
      prefix: -f
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: pattern file
    inputBinding:
      position: 101
      prefix: -p
  - id: quality_score_offset
    type:
      - 'null'
      - string
    doc: offset for quality scores
    default: autodetect
    inputBinding:
      position: 101
      prefix: -Q
  - id: rewrite_pattern_file
    type:
      - 'null'
      - boolean
    doc: rewrite pattern file
    default: 1
    inputBinding:
      position: 101
      prefix: -R
  - id: seed_length
    type:
      - 'null'
      - int
    doc: length of seed
    default: 32
    inputBinding:
      position: 101
      prefix: -l
  - id: sequence_similarity
    type:
      - 'null'
      - float
    doc: sequence similarity
    default: 0.995
    inputBinding:
      position: 101
      prefix: --similarity
  - id: text_file
    type: File
    doc: text file name
    inputBinding:
      position: 101
      prefix: -t
  - id: transitions_fraction
    type:
      - 'null'
      - float
    doc: transitions fraction of mutations
    default: 0.71
    inputBinding:
      position: 101
      prefix: --trans
  - id: unique_match
    type:
      - 'null'
      - boolean
    doc: search for unique match
    default: 1
    inputBinding:
      position: 101
      prefix: -u
  - id: use_quality_scores
    type:
      - 'null'
      - boolean
    doc: use quality scores
    default: 1
    inputBinding:
      position: 101
      prefix: -q
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output filename
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/real:1.0--he941832_1
