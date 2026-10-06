cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - am_compress
label: art_modern_am_compress
doc: "Compress a file with gzip or bgzip (art_modern helper).\n\nTool homepage: https://github.com/YU-Zhejian/art_modern"
inputs:
  - id: o_compressed
    type: string
    doc: Destination of output compressed file. Unset to disable the writer.
    inputBinding:
      position: 1
      prefix: --o-compressed
  - id: o_compressed_compression
    type:
      - 'null'
      - string
    doc: Compression type for the output file. Supported values are 'gzip', 'bgzip',
      and 'none'. If not set, it will be inferred from the file extension.
    inputBinding:
      position: 1
      prefix: --o-compressed-compression
  - id: o_compressed_compression_level
    type:
      - 'null'
      - int
    doc: 'Compression level for gzip compression. Valid values are typically between
      1 (fastest) and 9 (best compression). Default is 6. Not used when no compression.
      (default: 6)'
    inputBinding:
      position: 1
      prefix: --o-compressed-compression_level
  - id: o_compressed_buffer_size
    type:
      - 'null'
      - long
    doc: 'Buffer size in bytes for writing. Default is 1 MiB (1048576 bytes). (default:
      1048576)'
    inputBinding:
      position: 1
      prefix: --o-compressed-buffer_size
  - id: o_compressed_num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for compression. Only applicable for bgzip compression.
      Default is 1 (no multithreading). (default: 1)'
    inputBinding:
      position: 1
      prefix: --o-compressed-num_threads
  - id: i_file
    type: File
    doc: Path to the input file.
    inputBinding:
      position: 1
      prefix: --i-file
  - id: i_buffer_size
    type:
      - 'null'
      - long
    doc: 'Size (in bytes) of the buffer used to read the input file. (default: 4096)'
    inputBinding:
      position: 1
      prefix: --i-buffer_size
outputs:
  - id: compressed
    type: File
    doc: Compressed output file.
    outputBinding:
      glob: $(inputs.o_compressed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art_modern:1.5.1--hc80e578_0
