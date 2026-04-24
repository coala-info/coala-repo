cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - rowsub
label: yame_rowsub
doc: "Subset (slice) rows from each dataset (record) in a CX stream. Output is always
  written to stdout.\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_cx
    type: File
    doc: Input CX stream
    inputBinding:
      position: 1
  - id: block_index_and_size
    type:
      - 'null'
      - string
    doc: 'Keep rows: beg0 = blockIndex0 * blockSize, end0 = (blockIndex0+1)*blockSize
      - 1. If <blockSize> is omitted, default blockSize=1000000.'
    inputBinding:
      position: 102
      prefix: -I
  - id: block_range
    type:
      - 'null'
      - string
    doc: Keep rows in [beg0, end0] where end0 = end1-1. If <end1> is omitted, 
      keep a single row at beg0.
    inputBinding:
      position: 102
      prefix: -B
  - id: coordinate_file
    type:
      - 'null'
      - File
    doc: One [chrm]_[beg1] per line (1-based beg). Requires -R. Order preserved;
      no sorting required.
    inputBinding:
      position: 102
      prefix: -L
  - id: emit_subsetted_row_coordinates
    type:
      - 'null'
      - boolean
    doc: If -R is provided, emit the subsetted row coordinates as the FIRST 
      dataset.
    inputBinding:
      position: 102
      prefix: '-1'
  - id: index_file
    type:
      - 'null'
      - File
    doc: One [index1] per line (1-based). Order preserved; no sorting required.
    inputBinding:
      position: 102
      prefix: -l
  - id: mask_file
    type:
      - 'null'
      - File
    doc: Mask file (format 0/1 only). Rows with bit=1 are kept.
    inputBinding:
      position: 102
      prefix: -m
  - id: row_coordinate_file
    type:
      - 'null'
      - File
    doc: Row coordinate dataset (format 7; e.g. BED-like coordinates).
    inputBinding:
      position: 102
      prefix: -R
outputs:
  - id: output_cx
    type:
      - 'null'
      - File
    doc: Output CX stream (written to stdout)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
