cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmindex compress
label: kmindex_compress
doc: "Compress index.\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs:
  - id: block_size
    type:
      - 'null'
      - int
    doc: Size of uncompressed blocks, in megabytes.
    inputBinding:
      position: 101
      prefix: --block-size
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check query results after compressing.
    inputBinding:
      position: 101
      prefix: --check
  - id: column_per_block
    type:
      - 'null'
      - int
    doc: Reorder columns by group of N. Should be a multiple of 8 (0=all)
    inputBinding:
      position: 101
      prefix: --column-per-block
  - id: cpr_level
    type:
      - 'null'
      - int
    doc: Compression level in [1,22])
    inputBinding:
      position: 101
      prefix: --cpr-level
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete uncompressed index after compressing.
    inputBinding:
      position: 101
      prefix: --delete
  - id: global_index
    type: string
    doc: Global index path.
    inputBinding:
      position: 101
      prefix: --global-index
  - id: name
    type: string
    doc: Index name.
    inputBinding:
      position: 101
      prefix: --name
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: Reorder columns before compressing.
    inputBinding:
      position: 101
      prefix: --reorder
  - id: sampling
    type:
      - 'null'
      - int
    doc: Number of rows to sample for reordering.
    inputBinding:
      position: 101
      prefix: --sampling
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - string
    doc: Verbosity level [debug|info|warning|error].
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
stdout: kmindex_compress.out
