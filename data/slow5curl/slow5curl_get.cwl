cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5curl
  - get
label: slow5curl_get
doc: "Display the read entry for each specified READ_ID from a remote blow5 file. If
  READ_ID is not specified, a newline separated list of read ids will be read from the
  standard input.\n\nTool homepage: https://github.com/BonsonW/slow5curl"
inputs:
  - id: slow5_file
    type: string
    doc: URL of the remote BLOW5 file
    inputBinding:
      position: 100
  - id: read_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: List of read IDs to retrieve
    inputBinding:
      position: 101
  - id: output_format
    type: ['null', string]
    doc: Specify output file format (slow5 or blow5)
    inputBinding:
      position: 1
      prefix: --to
  - id: output_file_path
    type: ['null', string]
    doc: 'Output contents to FILE (.slow5 or .blow5 extensions) [default: stdout]'
    inputBinding:
      position: 1
      prefix: --output
  - id: index_file
    type: ['null', File, string]
    doc: Path (local file or URL) to a custom slow5 index
    inputBinding:
      position: 1
      prefix: --index
  - id: cache_file_path
    type: ['null', string]
    doc: Save the downloaded index to the specified file path
    inputBinding:
      position: 1
      prefix: --cache
  - id: record_compression_method
    type: ['null', string]
    doc: Record compression method (none, zlib or zstd; only for blow5 format)
    inputBinding:
      position: 1
      prefix: --compress
  - id: signal_compression_method
    type: ['null', string]
    doc: Signal compression method (none or svb-zd; only for blow5 format)
    inputBinding:
      position: 1
      prefix: --sig-compress
  - id: threads
    type: ['null', int]
    doc: Number of threads
    inputBinding:
      position: 1
      prefix: --threads
  - id: batch_size
    type: ['null', int]
    doc: Number of records loaded to the memory at once
    inputBinding:
      position: 1
      prefix: --batchsize
  - id: list_file
    type: ['null', File]
    doc: List of read ids provided as a single-column text file with one read id per line
    inputBinding:
      position: 1
      prefix: --list
  - id: skip_not_found
    type: ['null', boolean]
    doc: Warn and continue if a read_id was not found
    inputBinding:
      position: 1
      prefix: --skip
  - id: retry_count
    type: ['null', int]
    doc: Number of retries on a fetch before aborting the batch
    inputBinding:
      position: 1
      prefix: --retry
  - id: wait_time
    type: ['null', int]
    doc: Time (sec) to wait before the next fetch retry
    inputBinding:
      position: 1
      prefix: --wait
stdout: slow5curl_get.out
outputs:
  - id: output_file
    type: ['null', File]
    doc: Output file written with --output (.slow5 or .blow5)
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: cache_file
    type: ['null', File]
    doc: Downloaded index saved with --cache
    outputBinding:
      glob: $(inputs.cache_file_path)
  - id: stdout_records
    type: File
    doc: Read records written to standard output (empty when --output is used)
    outputBinding:
      glob: slow5curl_get.out
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0
