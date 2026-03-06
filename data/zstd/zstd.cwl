cwlVersion: v1.2
class: CommandLineTool
baseCommand: zstd
label: zstd
doc: zstd command line interface for compression and decompression
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: a filename; with no FILE, or when FILE is - , read standard input
    inputBinding:
      position: 1
  - id: adapt
    type:
      - 'null'
      - boolean
    doc: dynamically adapt compression level to I/O conditions
    inputBinding:
      position: 102
      prefix: --adapt
  - id: benchmark
    type:
      - 'null'
      - int
    doc: 'benchmark file(s), using # compression level'
    default: 3
    inputBinding:
      position: 102
      prefix: -b
  - id: benchmark_end_level
    type:
      - 'null'
      - int
    doc: 'test all compression levels from -bX to #'
    default: 1
    inputBinding:
      position: 102
      prefix: -e
  - id: block_size
    type:
      - 'null'
      - int
    doc: 'select size of each job (default: 0==automatic)'
    default: 0
    inputBinding:
      position: 102
      prefix: -B
  - id: check
    type:
      - 'null'
      - boolean
    doc: 'integrity check (default: enabled)'
    inputBinding:
      position: 102
      prefix: --check
  - id: compression_level
    type:
      - 'null'
      - int
    doc: 'compression level (1-19, default: 3)'
    default: 3
    inputBinding:
      position: 102
      prefix: -#
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: decompression
    inputBinding:
      position: 102
      prefix: -d
  - id: dict_id
    type:
      - 'null'
      - int
    doc: force dictionary ID to specified value
    inputBinding:
      position: 102
      prefix: --dictID
  - id: dictionary
    type:
      - 'null'
      - File
    doc: use `file` as Dictionary
    inputBinding:
      position: 102
      prefix: -D
  - id: eval_time
    type:
      - 'null'
      - int
    doc: minimum evaluation time in seconds
    default: 3
    inputBinding:
      position: 102
      prefix: -i
  - id: fast
    type:
      - 'null'
      - int
    doc: switch to ultra fast compression level
    default: 1
    inputBinding:
      position: 102
      prefix: --fast
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite output without prompting and (de)compress links
    inputBinding:
      position: 102
      prefix: -f
  - id: format
    type:
      - 'null'
      - string
    doc: compress files to the specified format (zstd, gzip, xz, lzma, lz4)
    default: zstd
    inputBinding:
      position: 102
      prefix: --format
  - id: keep_source
    type:
      - 'null'
      - boolean
    doc: preserve source file(s) (default)
    inputBinding:
      position: 102
      prefix: -k
  - id: list
    type:
      - 'null'
      - boolean
    doc: print information about zstd compressed files
    inputBinding:
      position: 102
      prefix: -l
  - id: long
    type:
      - 'null'
      - int
    doc: enable long distance matching with given window log
    default: 27
    inputBinding:
      position: 102
      prefix: --long
  - id: max_dict
    type:
      - 'null'
      - int
    doc: limit dictionary to specified size
    default: 112640
    inputBinding:
      position: 102
      prefix: --maxdict
  - id: memory_limit
    type:
      - 'null'
      - int
    doc: Set a memory usage limit for decompression
    inputBinding:
      position: 102
      prefix: -M
  - id: no_dict_id
    type:
      - 'null'
      - boolean
    doc: don't write dictID into header (dictionary compression)
    inputBinding:
      position: 102
      prefix: --no-dictID
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: do not display the progress bar
    inputBinding:
      position: 102
      prefix: --no-progress
  - id: priority_rt
    type:
      - 'null'
      - boolean
    doc: set process priority to real-time
    inputBinding:
      position: 102
      prefix: --priority=rt
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: suppress warnings; specify twice to suppress errors too
    inputBinding:
      position: 102
      prefix: -q
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: operate recursively on directories
    inputBinding:
      position: 102
      prefix: -r
  - id: remove_source
    type:
      - 'null'
      - boolean
    doc: remove source file(s) after successful de/compression
    inputBinding:
      position: 102
      prefix: --rm
  - id: rsyncable
    type:
      - 'null'
      - boolean
    doc: compress using a rsync-friendly method (-B sets block size)
    inputBinding:
      position: 102
      prefix: --rsyncable
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: 'sparse mode (default: enabled on file, disabled on stdout)'
    inputBinding:
      position: 102
      prefix: --sparse
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: force write to standard output, even if it is the console
    inputBinding:
      position: 102
      prefix: -c
  - id: test
    type:
      - 'null'
      - boolean
    doc: test compressed file integrity
    inputBinding:
      position: 102
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: 'spawns # compression threads (default: 1, 0==# cores)'
    default: 1
    inputBinding:
      position: 102
      prefix: -T
  - id: train
    type:
      - 'null'
      - int
    doc: create a dictionary from a training set of files
    inputBinding:
      position: 102
      prefix: --train
  - id: ultra
    type:
      - 'null'
      - boolean
    doc: enable levels beyond 19, up to 22 (requires more memory)
    inputBinding:
      position: 102
      prefix: --ultra
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: result stored into `file` (only if 1 input file)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/zstd:v1.3.8dfsg-3-deb_cv1
s:url: https://github.com/facebook/zstd
$namespaces:
  s: https://schema.org/
