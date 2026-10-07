cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cleanifier
  - filter
label: cleanifier_filter
doc: "remove all reads that belong to the specified species\n\nTool homepage: https://gitlab.com/rahmannlab/cleanifier"
inputs:
  - id: cfg
    type:
      - 'null'
      - File
    doc: "Path to a configuration file."
    inputBinding:
      position: 101
      prefix: --cfg
  - id: fastq
    type:
      type: array
      items: File
    doc: "single or first paired-end FASTQ file to filter (required)"
    inputBinding:
      position: 101
      prefix: --fastq
  - id: pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: "second paired-end FASTQ file (only together with --fastq)"
    inputBinding:
      position: 101
      prefix: --pairs
  - id: index
    type: File
    doc: "existing index: give the .hash file; the index name (without .hash) is passed, with the .info file beside it (required)"
    secondaryFiles:
      - pattern: "^.info"
        required: true
    inputBinding:
      position: 101
      prefix: --index
      valueFrom: "$(self.path.replace(/\\.hash$/, ''))"
  - id: shared
    type:
      - 'null'
      - boolean
    doc: "index should be loaded via shared memory"
    inputBinding:
      position: 101
      prefix: --shared
  - id: count
    type:
      - 'null'
      - boolean
    doc: "only count reads or read pairs for each class, do not output any FASTQ"
    inputBinding:
      position: 101
      prefix: --count
  - id: out
    type:
      - 'null'
      - string
    doc: "prefix for output files (directory and name prefix)"
    inputBinding:
      position: 101
      prefix: --out
  - id: keep_host
    type:
      - 'null'
      - boolean
    doc: "output both the filtered FASTQ file and a file with the removed host reads; only together with --out"
    inputBinding:
      position: 101
      prefix: --keep-host
  - id: threads
    type:
      - 'null'
      - int
    doc: "maximum number of worker threads for classification (default: 8)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: compression
    type:
      - 'null'
      - string
    doc: "compression of output files (none, gz, bz2, xz)"
    inputBinding:
      position: 101
      prefix: --compression
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: "maximum number of compression threads (default: 2)"
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "compression level; supported levels depend on compression type (1-11 for gz, 1-9 for bz2 and 0-9 for xz) (default: 1)"
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: "sensitive (slower) mode that queries all k-mers"
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: threshold
    type:
      - 'null'
      - float
    doc: "threshold at which reads are filtered (default: 0.5)"
    inputBinding:
      position: 101
      prefix: --threshold
  - id: prefetchlevel
    type:
      - 'null'
      - int
    doc: "amount of prefetching: none (0), second bucket (1), all buckets (2); supported only for hash table (default: 0)"
    inputBinding:
      position: 101
      prefix: --prefetchlevel
  - id: prefetch_offset
    type:
      - 'null'
      - int
    doc: "position to prefetch in advance (> 0) (default: 8)"
    inputBinding:
      position: 101
      prefix: --prefetch-offset
  - id: buffersize
    type:
      - 'null'
      - int
    doc: "io buffersize; in powers of two default 16 (2^16 bytes, fast on SDDs); increase on HDD to e.g. 24"
    inputBinding:
      position: 101
      prefix: --buffersize
  - id: progress
    type:
      - 'null'
      - boolean
    doc: "show progress"
    inputBinding:
      position: 101
      prefix: --progress
outputs:
  - id: filtered_reads
    type:
      type: array
      items: File
    doc: "Filtered FASTQ files (and removed host reads with --keep-host)"
    outputBinding:
      glob: "$(inputs.out ? inputs.out + '*' : [])"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
stdout: cleanifier_filter.out
