cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cobs
  - generate-queries
label: cobs_generate-queries
doc: "Generates positive and negative queries from base documents.\n\nTool homepage:
  https://panthema.net/cobs"
inputs:
  - id: path
    type: Directory
    doc: path to base documents
    inputBinding:
      position: 1
  - id: file_type
    type:
      - 'null'
      - string
    doc: '"list" to read a file list, or filter documents by file type (any, text,
      cortex, fasta, fastq, etc)'
    inputBinding:
      position: 102
      prefix: --file-type
  - id: negative
    type:
      - 'null'
      - int
    doc: construct this number of random non-existing negative queries
    default: 0
    inputBinding:
      position: 102
      prefix: --negative
  - id: positive
    type:
      - 'null'
      - int
    doc: pick this number of existing positive queries
    default: 0
    inputBinding:
      position: 102
      prefix: --positive
  - id: seed
    type:
      - 'null'
      - string
    doc: random seed
    inputBinding:
      position: 102
      prefix: --seed
  - id: size
    type:
      - 'null'
      - int
    doc: extend positive terms with random data to this size
    inputBinding:
      position: 102
      prefix: --size
  - id: term_size
    type:
      - 'null'
      - int
    doc: term size (k-mer size)
    default: 31
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
  - id: true_negative
    type:
      - 'null'
      - boolean
    doc: check that negative queries actually are not in the documents (slow)
    inputBinding:
      position: 102
      prefix: --true-negative
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: output file path
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
