cwlVersion: v1.2
class: CommandLineTool
baseCommand: zstd
label: zstd_de
doc: "Compress or decompress the INPUT file(s); reads from STDIN if INPUT is `-` or
  not provided.\n\nTool homepage: https://github.com/facebook/zstd"
inputs:
  - id: inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s) to compress or decompress
    inputBinding:
      position: 1
  - id: adapt
    type:
      - 'null'
      - boolean
    doc: Dynamically adapt compression level to I/O conditions.
    inputBinding:
      position: 102
      prefix: --adapt
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Perform decompression.
    inputBinding:
      position: 102
      prefix: --decompress
  - id: dict
    type:
      - 'null'
      - File
    doc: Use DICT as the dictionary for compression or decompression.
    inputBinding:
      position: 102
      prefix: -D
  - id: dictID
    type:
      - 'null'
      - int
    doc: 'Force dictionary ID to #.'
    inputBinding:
      position: 102
      prefix: --dictID
  - id: exclude_compressed
    type:
      - 'null'
      - boolean
    doc: Only compress files that are not already compressed.
    inputBinding:
      position: 102
      prefix: --exclude-compressed
  - id: fast
    type:
      - 'null'
      - int
    doc: Use to very fast compression levels.
    default: 1
    inputBinding:
      position: 102
      prefix: --fast
  - id: filelist
    type:
      - 'null'
      - File
    doc: Read a list of files to operate on from LIST.
    inputBinding:
      position: 102
      prefix: --filelist
  - id: force
    type:
      - 'null'
      - boolean
    doc: Disable input and output checks. Allows overwriting existing files, 
      receiving input from the console, printing output to STDOUT, and operating
      on links, block devices, etc.
    inputBinding:
      position: 102
      prefix: --force
  - id: format
    type:
      - 'null'
      - string
    doc: Compress files to the specified format (zstd, gzip).
    default: zstd
    inputBinding:
      position: 102
      prefix: --format
  - id: job_size
    type:
      - 'null'
      - int
    doc: 'Set job size to #.'
    default: 0
    inputBinding:
      position: 102
      prefix: -B
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Preserve INPUT file(s).
    inputBinding:
      position: 102
      prefix: --keep
  - id: list
    type:
      - 'null'
      - boolean
    doc: Print information about Zstandard-compressed files.
    inputBinding:
      position: 102
      prefix: -l
  - id: long
    type:
      - 'null'
      - int
    doc: 'Enable long distance matching with window log #.'
    default: 27
    inputBinding:
      position: 102
      prefix: --long
  - id: maxdict
    type:
      - 'null'
      - int
    doc: 'Limit dictionary to specified size #.'
    default: 112640
    inputBinding:
      position: 102
      prefix: --maxdict
  - id: memory_limit
    type:
      - 'null'
      - int
    doc: 'Set the memory usage limit to # megabytes.'
    inputBinding:
      position: 102
      prefix: -M
  - id: no_dictID
    type:
      - 'null'
      - boolean
    doc: Don't write dictID into the header (dictionary compression only).
    inputBinding:
      position: 102
      prefix: --no-dictID
  - id: patch_from
    type:
      - 'null'
      - File
    doc: Use REF as the reference point for Zstandard's diff engine.
    inputBinding:
      position: 102
      prefix: --patch-from
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Suppress warnings; pass twice to suppress errors.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Operate recursively on directories.
    inputBinding:
      position: 102
      prefix: -r
  - id: rm
    type:
      - 'null'
      - boolean
    doc: Remove INPUT file(s) after successful (de)compression.
    inputBinding:
      position: 102
      prefix: --rm
  - id: rsyncable
    type:
      - 'null'
      - boolean
    doc: Compress using a rsync-friendly method.
    inputBinding:
      position: 102
      prefix: --rsyncable
  - id: single_thread
    type:
      - 'null'
      - boolean
    doc: Share a single thread for I/O and compression.
    inputBinding:
      position: 102
      prefix: --single-thread
  - id: size_hint
    type:
      - 'null'
      - int
    doc: 'Optimize compression parameters for streaming input of approximately size
      #.'
    inputBinding:
      position: 102
      prefix: --size-hint
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Write to STDOUT (even if it is a console) and keep the INPUT file(s).
    inputBinding:
      position: 102
      prefix: --stdout
  - id: stream_size
    type:
      - 'null'
      - int
    doc: Specify size of streaming input from STDIN.
    inputBinding:
      position: 102
      prefix: --stream-size
  - id: target_compressed_block_size
    type:
      - 'null'
      - int
    doc: 'Generate compressed blocks of approximately # size.'
    inputBinding:
      position: 102
      prefix: --target-compressed-block-size
  - id: test
    type:
      - 'null'
      - boolean
    doc: Test compressed file integrity.
    inputBinding:
      position: 102
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Spawn # compression threads. Pass 0 for core count.'
    default: 1
    inputBinding:
      position: 102
      prefix: -T
  - id: trace
    type:
      - 'null'
      - File
    doc: Log tracing information to LOG.
    inputBinding:
      position: 102
      prefix: --trace
  - id: train
    type:
      - 'null'
      - boolean
    doc: Create a dictionary from a training set of files.
    inputBinding:
      position: 102
      prefix: --train
  - id: ultra
    type:
      - 'null'
      - boolean
    doc: Enable levels beyond 19, up to 22; requires more memory.
    inputBinding:
      position: 102
      prefix: --ultra
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to a single file, OUTPUT.
    outputBinding:
      glob: $(inputs.output)
  - id: output_dir_flat
    type:
      - 'null'
      - Directory
    doc: Store processed files in DIR.
    outputBinding:
      glob: $(inputs.output_dir_flat)
  - id: output_dir_mirror
    type:
      - 'null'
      - Directory
    doc: Store processed files in DIR, respecting original directory structure.
    outputBinding:
      glob: $(inputs.output_dir_mirror)
