cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobs compact-construct
label: cobs_compact-construct
doc: "Constructs a COBS compact index.\n\nTool homepage: https://panthema.net/cobs"
inputs:
  - id: input
    type: File
    doc: path to the input directory or file
    inputBinding:
      position: 1
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: erase output directory if it exists
    inputBinding:
      position: 102
      prefix: --clobber
  - id: continue_build
    type:
      - 'null'
      - boolean
    doc: continue in existing output directory
    inputBinding:
      position: 102
      prefix: --continue
  - id: false_positive_rate
    type:
      - 'null'
      - float
    doc: false positive rate
    inputBinding:
      position: 102
      prefix: --false-positive-rate
  - id: file_type
    type:
      - 'null'
      - string
    doc: '"list" to read a file list, or filter documents by file type (any, text,
      cortex, fasta, fastq, etc)'
    inputBinding:
      position: 102
      prefix: --file-type
  - id: keep_temporary
    type:
      - 'null'
      - boolean
    doc: keep temporary files during construction
    inputBinding:
      position: 102
      prefix: --keep-temporary
  - id: memory
    type:
      - 'null'
      - string
    doc: memory in bytes to use
    inputBinding:
      position: 102
      prefix: --memory
  - id: no_canonicalize
    type:
      - 'null'
      - boolean
    doc: don't canonicalize DNA k-mers
    inputBinding:
      position: 102
      prefix: --no-canonicalize
  - id: num_hashes
    type:
      - 'null'
      - int
    doc: number of hash functions
    inputBinding:
      position: 102
      prefix: --num-hashes
  - id: page_size
    type:
      - 'null'
      - string
    doc: the page size of the compact the index
    inputBinding:
      position: 102
      prefix: --page-size
  - id: term_size
    type:
      - 'null'
      - int
    doc: term size (k-mer size)
    inputBinding:
      position: 102
      prefix: --term-size
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmp_path
    type:
      - 'null'
      - Directory
    doc: directory for intermediate index files
    inputBinding:
      position: 102
      prefix: --tmp-path
outputs:
  - id: out_file
    type: File
    doc: path to the output .cobs_compact index file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
