cwlVersion: v1.2
class: CommandLineTool
baseCommand: grabix_index
label: grabix_index
doc: "Index a tabix-indexed file.\n\nTool homepage: https://github.com/arq5x/grabix"
inputs:
  - id: input_file
    type: File
    doc: The input file to index.
    inputBinding:
      position: 1
  - id: comment_char
    type:
      - 'null'
      - string
    doc: Character indicating a comment line.
    default: '#'
    inputBinding:
      position: 102
      prefix: --comment-char
  - id: end_column
    type:
      - 'null'
      - int
    doc: Column number for the end position (1-based).
    inputBinding:
      position: 102
      prefix: --end-column
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing index file without asking.
    inputBinding:
      position: 102
      prefix: --force
  - id: preset
    type:
      - 'null'
      - string
    doc: Preset for tabix indexing (e.g., 'gff', 'bed', 'sam').
    inputBinding:
      position: 102
      prefix: --preset
  - id: sequence_column
    type:
      - 'null'
      - int
    doc: Column number for the sequence/chromosome (1-based).
    inputBinding:
      position: 102
      prefix: --sequence-column
  - id: start_column
    type:
      - 'null'
      - int
    doc: Column number for the start position (1-based).
    inputBinding:
      position: 102
      prefix: --start-column
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for indexing.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output index file. Defaults to <input_file>.px.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
