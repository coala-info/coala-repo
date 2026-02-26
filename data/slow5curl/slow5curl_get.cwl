cwlVersion: v1.2
class: CommandLineTool
baseCommand: slow5curl_get
label: slow5curl_get
doc: "Display the read entry for each specified READ_ID from a blow5 file. If READ_ID
  is not specified, a newline separated list of read ids will be read from the standard
  input.\n\nTool homepage: https://github.com/BonsonW/slow5curl"
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
  - id: cache_file
    type:
      - 'null'
      - File
    doc: Save the downloaded index to the specified file path
    default: 'false'
    inputBinding:
      position: 103
      prefix: --cache
  - id: index_file
    type:
      - 'null'
      - File
    doc: Specify path to a custom slow5 index
    inputBinding:
      position: 103
      prefix: --index
  - id: list_file
    type:
      - 'null'
      - File
    doc: List of read ids provided as a single-column text file with one read id
      per line.
    inputBinding:
      position: 103
      prefix: --list
  - id: output_format
    type:
      - 'null'
      - string
    doc: Specify output file format (slow5 or blow5)
    inputBinding:
      position: 103
      prefix: --to
  - id: record_compression_method
    type:
      - 'null'
      - string
    doc: Record compression method (only for blow5 format)
    default: zlib
    inputBinding:
      position: 103
      prefix: --compress
  - id: retry_count
    type:
      - 'null'
      - int
    doc: Number of retries on a fetch before aborting the batch
    default: 1
    inputBinding:
      position: 103
      prefix: --retry
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
    default: 128
    inputBinding:
      position: 103
      prefix: --threads
  - id: wait_time
    type:
      - 'null'
      - int
    doc: Time (sec) to wait before the next fetch retry
    inputBinding:
      position: 103
      prefix: --wait
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output contents to FILE (.slow5 or .blow5 extensions)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0
