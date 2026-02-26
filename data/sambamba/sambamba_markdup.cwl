cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba-markdup
label: sambamba_markdup
doc: "Marks the duplicates without removing them\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: input_bam
    type:
      type: array
      items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: specify compression level of the resulting file (from 0 to 9)
    inputBinding:
      position: 102
      prefix: --compression-level
  - id: hash_table_size
    type:
      - 'null'
      - int
    doc: size of hash table for finding read pairs (default is 262144 reads); 
      will be rounded down to the nearest power of two; should be > (average 
      coverage) * (insert size) for good performance
    default: 262144
    inputBinding:
      position: 102
      prefix: --hash-table-size
  - id: io_buffer_size
    type:
      - 'null'
      - int
    doc: two buffers of BUFFER_SIZE *megabytes* each are used for reading and 
      writing BAM during the second pass (default is 128)
    default: 128
    inputBinding:
      position: 102
      prefix: --io-buffer-size
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: overflow_list_size
    type:
      - 'null'
      - int
    doc: size of the overflow list where reads, thrown from the hash table, get 
      a second chance to meet their pairs (default is 200000 reads); increasing 
      the size reduces the number of temporary files created
    default: 200000
    inputBinding:
      position: 102
      prefix: --overflow-list-size
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: remove duplicates instead of just marking them
    inputBinding:
      position: 102
      prefix: --remove-duplicates
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: show progressbar in STDERR
    inputBinding:
      position: 102
      prefix: --show-progress
  - id: sort_buffer_size
    type:
      - 'null'
      - int
    doc: total amount of memory (in *megabytes*) used for sorting purposes; the 
      default is 2048, increasing it will reduce the number of created temporary
      files and the time spent in the main thread
    default: 2048
    inputBinding:
      position: 102
      prefix: --sort-buffer-size
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify directory for temporary files
    inputBinding:
      position: 102
      prefix: --tmpdir
outputs:
  - id: output_bam
    type: File
    doc: Output BAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
