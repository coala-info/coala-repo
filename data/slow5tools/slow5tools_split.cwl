cwlVersion: v1.2
class: CommandLineTool
baseCommand: slow5tools split
label: slow5tools_split
doc: "Split a single a SLOW5/BLOW5 file into multiple separate files.\n\nTool homepage:
  https://github.com/hasindu2008/slow5tools"
inputs:
  - id: input_file_or_dir
    type:
      - 'null'
      - type: array
        items: File
    doc: SLOW5/BLOW5 file or directory to split
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: number of records loaded to the memory at once
    inputBinding:
      position: 102
      prefix: --batchsize
  - id: demux_categories_column
    type:
      - 'null'
      - string
    doc: specify categories column name ['barcode_arrangement']
    inputBinding:
      position: 102
      prefix: --demux-code
  - id: demux_missing_category_name
    type:
      - 'null'
      - string
    doc: uncategorised reads to category named STR
    inputBinding:
      position: 102
      prefix: --demux-missing
  - id: demux_read_ids_column
    type:
      - 'null'
      - string
    doc: specify read IDs column name ['parent_read_id']
    inputBinding:
      position: 102
      prefix: --demux-rid
  - id: demux_tsv_path
    type:
      - 'null'
      - File
    doc: split reads according to TSV file
    inputBinding:
      position: 102
      prefix: --demux
  - id: demux_unique_category_name
    type:
      - 'null'
      - string
    doc: multi-category reads to category named STR
    inputBinding:
      position: 102
      prefix: --demux-uniq
  - id: lossless
    type:
      - 'null'
      - boolean
    doc: retain information in auxiliary fields during the conversion
    inputBinding:
      position: 102
      prefix: --lossless
  - id: num_files
    type:
      - 'null'
      - int
    doc: split reads into n files evenly
    inputBinding:
      position: 102
      prefix: --files
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output to directory
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: output_format
    type:
      - 'null'
      - string
    doc: specify output file format [blow5, auto detected using extension if -o 
      FILE is provided]
    inputBinding:
      position: 102
      prefix: --to
  - id: reads_per_file
    type:
      - 'null'
      - int
    doc: split into n reads, i.e., each file will have n reads
    inputBinding:
      position: 102
      prefix: --reads
  - id: record_compression_method
    type:
      - 'null'
      - string
    doc: record compression method [zlib] (only for blow5 format)
    inputBinding:
      position: 102
      prefix: --compress
  - id: signal_compression_method
    type:
      - 'null'
      - string
    doc: signal compression method [svb-zd] (only for blow5 format)
    inputBinding:
      position: 102
      prefix: --sig-compress
  - id: split_by_read_group
    type:
      - 'null'
      - boolean
    doc: split multi read group file into single read group files
    inputBinding:
      position: 102
      prefix: --groups
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
stdout: slow5tools_split.out
