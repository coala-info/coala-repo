cwlVersion: v1.2
class: CommandLineTool
baseCommand: bmtool
label: bmtagger_bmtool
doc: "Build word mask for subject database\n\nTool homepage: https://github.com/movingpictures83/BMTagger"
inputs:
  - id: bit_test
    type:
      - 'null'
      - boolean
    doc: Test bit operations [off]
    inputBinding:
      position: 101
      prefix: --bit-test
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress bitmask (requires version 2) [off]
    inputBinding:
      position: 101
      prefix: --compress
  - id: diff
    type:
      - 'null'
      - boolean
    doc: Diff source and result before writing, repport differences [off]
    inputBinding:
      position: 101
      prefix: --diff
  - id: extra_compress
    type:
      - 'null'
      - boolean
    doc: Compress bitmask (requires version 2) looking for duplicate extension 
      sets [off]
    inputBinding:
      position: 101
      prefix: --extra-compress
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Input fasta or blastdb file
    default: ''
    inputBinding:
      position: 101
      prefix: --fasta-file
  - id: fasta_parse_ids
    type:
      - 'null'
      - int
    doc: Parse FASTA ids (becomes broken if ranges are used)
    default: 0
    inputBinding:
      position: 101
      prefix: --fasta-parse-ids
  - id: gi_list
    type:
      - 'null'
      - string
    doc: Set gi list for blastdb file
    default: ''
    inputBinding:
      position: 101
      prefix: --gi-list
  - id: input_file
    type:
      - 'null'
      - File
    doc: Set word bitmask file as input
    default: ''
    inputBinding:
      position: 101
      prefix: --input-file
  - id: max_amb
    type:
      - 'null'
      - int
    doc: Maximal number of ambiguities to count
    default: 0
    inputBinding:
      position: 101
      prefix: --max-amb
  - id: max_word_count
    type:
      - 'null'
      - int
    doc: Do not include words counted more than this value (for 16-mers or less)
    default: 0
    inputBinding:
      position: 101
      prefix: --max-word-count
  - id: mmap
    type:
      - 'null'
      - boolean
    doc: Memory map source file instead of reading [off]
    inputBinding:
      position: 101
      prefix: --mmap
  - id: pack_count_bits
    type:
      - 'null'
      - int
    doc: Number of bits to reserve for entry count within segment
    default: 10
    inputBinding:
      position: 101
      prefix: --pack-count-bits
  - id: pack_offset_bits
    type:
      - 'null'
      - int
    doc: Number of bits in table to use for data segment offset
    default: 34
    inputBinding:
      position: 101
      prefix: --pack-offset-bits
  - id: pack_prefix_bits
    type:
      - 'null'
      - int
    doc: Bits to use for compression prefix
    default: 26
    inputBinding:
      position: 101
      prefix: --pack-prefix-bits
  - id: pattern
    type:
      - 'null'
      - string
    doc: Set pattern to use with discontiguous words, 0x or 0b prefix may be 
      used for hex or bin (-w## will be ignored)
    default: '0'
    inputBinding:
      position: 101
      prefix: --pattern
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not show progress indicators [off]
    inputBinding:
      position: 101
      prefix: --quiet
  - id: slow
    type:
      - 'null'
      - boolean
    doc: Slow copy (using query API - to check query api [off]
    inputBinding:
      position: 101
      prefix: --slow
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size to use
    default: 18
    inputBinding:
      position: 101
      prefix: --word-size
  - id: word_step
    type:
      - 'null'
      - int
    doc: Step (stride size) to use
    default: 1
    inputBinding:
      position: 101
      prefix: --word-step
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output word bitmask file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bmtagger:3.101--3
