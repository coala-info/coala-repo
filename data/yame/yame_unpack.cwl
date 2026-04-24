cwlVersion: v1.2
class: CommandLineTool
baseCommand: yame_unpack
label: yame_unpack
doc: "Print selected records from a .cx file as a tab-delimited table.\nEach output
  row is a genomic row index; each output column is a selected sample/record.\n\n\
  Tool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_cx_file
    type: File
    doc: Input .cx file
    inputBinding:
      position: 1
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample names to select
    inputBinding:
      position: 2
  - id: chunk_size_in_rows
    type:
      - 'null'
      - int
    doc: 'Chunk size in rows (default: 1000000).'
    inputBinding:
      position: 103
      prefix: -s
  - id: coordinate_print_mode
    type:
      - 'null'
      - int
    doc: "Coordinate print mode (default: 0):\n                0: chrm<tab>beg0<tab>end1\
      \   (cg-style)\n                1: chrm<tab>beg0<tab>end0   (allc-style)\n \
      \               else: chrm_beg1"
    inputBinding:
      position: 103
      prefix: -r
  - id: enable_chunked_printing
    type:
      - 'null'
      - boolean
    doc: Enable chunked printing (reduces peak memory).
    inputBinding:
      position: 103
      prefix: -c
  - id: inflated_unit_size_override
    type:
      - 'null'
      - int
    doc: 'Inflated unit-size override (0=auto; allowed: 1,2,4,6,8).'
    inputBinding:
      position: 103
      prefix: -u
  - id: output_all_records
    type:
      - 'null'
      - boolean
    doc: Output all records in the file.
    inputBinding:
      position: 103
      prefix: -a
  - id: output_first_n_samples
    type:
      - 'null'
      - int
    doc: Output the first N samples.
    inputBinding:
      position: 103
      prefix: -H
  - id: output_last_n_samples
    type:
      - 'null'
      - int
    doc: Output the last  N samples (requires index).
    inputBinding:
      position: 103
      prefix: -T
  - id: print_header_line
    type:
      - 'null'
      - boolean
    doc: Print a header line (column names).
    inputBinding:
      position: 103
      prefix: -C
  - id: row_coordinate_dataset
    type:
      - 'null'
      - File
    doc: Row coordinate dataset (CX; typically format 7).
    inputBinding:
      position: 103
      prefix: -R
  - id: sample_list_file
    type:
      - 'null'
      - File
    doc: "Sample list file (one name per line).\nIgnored if sample names are provided
      as trailing arguments."
    inputBinding:
      position: 103
      prefix: -l
  - id: value_print_mode
    type:
      - 'null'
      - int
    doc: "Print mode for certain formats (default: 0):\n                For format
      3 (MU):\n                  N == 0 : print packed MU (uint64)\n             \
      \     N  < 0 : print M<tab>U (two columns)\n                  N  > 0 : print
      beta; print NA if cov < N or cov==0\n                For format 6 (set+universe):\n\
      \                  N == 0 : print 0/1, NA coded as '2'\n                  N\
      \  < 0 : print value<tab>universe  (e.g., 1<tab>1, 0<tab>1, NA<tab>0)\n    \
      \              N  > 0 : print raw 2-bit code (FMT6_2BIT)"
    inputBinding:
      position: 103
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
stdout: yame_unpack.out
