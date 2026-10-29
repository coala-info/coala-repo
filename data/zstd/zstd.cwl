cwlVersion: v1.2
class: CommandLineTool
baseCommand: zstd
label: zstd
doc: |-
  zstd command line interface for compression and decompression

  Tool homepage: https://github.com/facebook/zstd
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: a filename; with no FILE, or when FILE is - , read standard input
    inputBinding:
      position: 10
  - id: output_file_path
    type: ['null', string]
    doc: result stored into `file` (only if 1 input file); dictionary name for --train
    inputBinding:
      position: 5
      prefix: -o
  - id: compression_level
    type: ['null', int]
    doc: 'compression level (1-19, default: 3)'
    inputBinding:
      position: 1
      prefix: '-'
      separate: false
  - id: decompress
    type: ['null', boolean]
    doc: decompression
    inputBinding:
      position: 1
      prefix: -d
  - id: dictionary
    type: ['null', File]
    doc: use `file` as Dictionary
    inputBinding:
      position: 1
      prefix: -D
  - id: force
    type: ['null', boolean]
    doc: overwrite output without prompting and (de)compress links
    inputBinding:
      position: 1
      prefix: -f
  - id: remove_source
    type: ['null', boolean]
    doc: remove source file(s) after successful de/compression
    inputBinding:
      position: 1
      prefix: --rm
  - id: keep_source
    type: ['null', boolean]
    doc: preserve source file(s) (default)
    inputBinding:
      position: 1
      prefix: -k
  - id: verbose
    type: ['null', boolean]
    doc: verbose mode
    inputBinding:
      position: 1
      prefix: -v
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: suppress warnings; specify twice to suppress errors too
    inputBinding:
      position: 1
      prefix: -q
  - id: stdout
    type: ['null', boolean]
    doc: force write to standard output, even if it is the console
    inputBinding:
      position: 1
      prefix: -c
  - id: list
    type: ['null', boolean]
    doc: print information about zstd compressed files
    inputBinding:
      position: 1
      prefix: -l
  - id: ultra
    type: ['null', boolean]
    doc: enable levels beyond 19, up to 22 (requires more memory)
    inputBinding:
      position: 1
      prefix: --ultra
  - id: long
    type: ['null', int]
    doc: 'enable long distance matching with given window log (default: 27)'
    inputBinding:
      position: 1
      prefix: --long=
      separate: false
  - id: fast
    type: ['null', int]
    doc: 'switch to ultra fast compression level (default: 1)'
    inputBinding:
      position: 1
      prefix: --fast=
      separate: false
  - id: adapt
    type: ['null', boolean]
    doc: dynamically adapt compression level to I/O conditions
    inputBinding:
      position: 1
      prefix: --adapt
  - id: threads
    type: ['null', int]
    doc: 'spawns # compression threads (default: 1, 0==# cores)'
    inputBinding:
      position: 1
      prefix: -T
      separate: false
  - id: block_size
    type: ['null', int]
    doc: 'select size of each job (default: 0==automatic)'
    inputBinding:
      position: 1
      prefix: -B
      separate: false
  - id: rsyncable
    type: ['null', boolean]
    doc: compress using a rsync-friendly method (-B sets block size)
    inputBinding:
      position: 1
      prefix: --rsyncable
  - id: no_dict_id
    type: ['null', boolean]
    doc: don't write dictID into header (dictionary compression)
    inputBinding:
      position: 1
      prefix: --no-dictID
  - id: check
    type: ['null', boolean]
    doc: 'integrity check (default: enabled)'
    inputBinding:
      position: 1
      prefix: --check
  - id: no_check
    type: ['null', boolean]
    doc: disable the integrity check
    inputBinding:
      position: 1
      prefix: --no-check
  - id: recursive
    type: ['null', boolean]
    doc: operate recursively on directories
    inputBinding:
      position: 1
      prefix: -r
  - id: format
    type: ['null', string]
    doc: compress files to the specified format (zstd, gzip, xz, lzma, lz4)
    inputBinding:
      position: 1
      prefix: --format=
      separate: false
  - id: test
    type: ['null', boolean]
    doc: test compressed file integrity
    inputBinding:
      position: 1
      prefix: --test
  - id: sparse
    type: ['null', boolean]
    doc: 'sparse mode (default: enabled on file, disabled on stdout)'
    inputBinding:
      position: 1
      prefix: --sparse
  - id: no_sparse
    type: ['null', boolean]
    doc: disable sparse mode
    inputBinding:
      position: 1
      prefix: --no-sparse
  - id: memory_limit
    type: ['null', int]
    doc: Set a memory usage limit for decompression
    inputBinding:
      position: 1
      prefix: -M
      separate: false
  - id: no_progress
    type: ['null', boolean]
    doc: do not display the progress bar
    inputBinding:
      position: 1
      prefix: --no-progress
  - id: train
    type: ['null', boolean]
    doc: create a dictionary from a training set of files (the input files)
    inputBinding:
      position: 1
      prefix: --train
  - id: train_cover
    type: ['null', string]
    doc: 'use the cover algorithm with optional args, e.g. k=#,d=#,steps=#,split=#'
    inputBinding:
      position: 1
      prefix: --train-cover=
      separate: false
  - id: train_fastcover
    type: ['null', string]
    doc: 'use the fast cover algorithm with optional args, e.g. k=#,d=#,f=#,steps=#,split=#,accel=#'
    inputBinding:
      position: 1
      prefix: --train-fastcover=
      separate: false
  - id: train_legacy
    type: ['null', string]
    doc: 'use the legacy algorithm with selectivity (e.g. s=9)'
    inputBinding:
      position: 1
      prefix: --train-legacy=
      separate: false
  - id: max_dict
    type: ['null', int]
    doc: 'limit dictionary to specified size (default: 112640)'
    inputBinding:
      position: 1
      prefix: --maxdict=
      separate: false
  - id: dict_id
    type: ['null', int]
    doc: 'force dictionary ID to specified value (default: random)'
    inputBinding:
      position: 1
      prefix: --dictID=
      separate: false
  - id: benchmark
    type: ['null', int]
    doc: 'benchmark file(s), using # compression level (default: 3)'
    inputBinding:
      position: 1
      prefix: -b
      separate: false
  - id: benchmark_end_level
    type: ['null', int]
    doc: 'test all compression levels from -bX to # (default: 1)'
    inputBinding:
      position: 1
      prefix: -e
      separate: false
  - id: eval_time
    type: ['null', int]
    doc: 'minimum evaluation time in seconds (default: 3s)'
    inputBinding:
      position: 1
      prefix: -i
      separate: false
  - id: priority_rt
    type: ['null', boolean]
    doc: set process priority to real-time
    inputBinding:
      position: 1
      prefix: --priority=rt
outputs:
  - id: output_file
    type: ['null', File]
    doc: result stored into `file` (only if 1 input file)
    outputBinding:
      glob: |-
        ${ return inputs.output_file_path ? inputs.output_file_path : []; }
  - id: stdout_text
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/zstd:v1.3.8dfsg-3-deb_cv1
s:url: https://github.com/facebook/zstd
$namespaces:
  s: https://schema.org/
