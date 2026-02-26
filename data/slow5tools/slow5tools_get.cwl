cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5tools
  - get
label: slow5tools_get
doc: "Display the read entry for each specified read id from a slow5 file. With no
  READ_ID, read from standard input newline separated read ids.\n\nTool homepage:
  https://github.com/hasindu2008/slow5tools"
inputs:
  - id: slow5_file
    type:
      - 'null'
      - File
    doc: Path to the SLOW5 file
    inputBinding:
      position: 1
  - id: read_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: List of read IDs to retrieve
    inputBinding:
      position: 2
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of records loaded to the memory at once
    default: 4096
    inputBinding:
      position: 103
      prefix: --batchsize
  - id: custom_index
    type:
      - 'null'
      - File
    doc: Path to a custom slow5 index (experimental).
    inputBinding:
      position: 103
      prefix: --index
  - id: output_format
    type:
      - 'null'
      - string
    doc: Specify output file format (slow5 or blow5)
    inputBinding:
      position: 103
      prefix: --to
  - id: read_id_list_file
    type:
      - 'null'
      - File
    doc: List of read ids provided as a single-column text file with one read id
      per line.
    inputBinding:
      position: 103
      prefix: --list
  - id: record_compression_method
    type:
      - 'null'
      - string
    doc: Record compression method (only for blow5 format)
    default: zlib
    inputBinding:
      position: 103
      prefix: --compress
  - id: signal_compression_method
    type:
      - 'null'
      - string
    doc: Signal compression method (only for blow5 format)
    default: svb-zd
    inputBinding:
      position: 103
      prefix: --sig-compress
  - id: skip_not_found
    type:
      - 'null'
      - boolean
    doc: Warn and continue if a read_id was not found.
    inputBinding:
      position: 103
      prefix: --skip
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 8
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output contents to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
