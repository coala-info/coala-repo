cwlVersion: v1.2
class: CommandLineTool
baseCommand: unnaf
label: naf_unnaf
doc: "Decompress NAF files\n\nTool homepage: https://github.com/KirillKryukov/naf"
inputs:
  - id: output_type
    type:
      - 'null'
      - string
    doc: Output type selection
    inputBinding:
      position: 1
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input NAF file
    inputBinding:
      position: 2
  - id: bit
    type:
      - 'null'
      - boolean
    doc: 4bit-encoded nucleotide sequence (binary data)
    inputBinding:
      position: 103
      prefix: --4bit
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Shortcut for "--binary-stdout --binary-stderr"
    inputBinding:
      position: 103
      prefix: --binary
  - id: binary_stderr
    type:
      - 'null'
      - boolean
    doc: Set stderr stream to binary mode.
    inputBinding:
      position: 103
      prefix: --binary-stderr
  - id: binary_stdout
    type:
      - 'null'
      - boolean
    doc: Set stdout stream to binary mode.
    inputBinding:
      position: 103
      prefix: --binary-stdout
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: FASTA-formatted sequences
    inputBinding:
      position: 103
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: FASTQ-formatted sequences
    inputBinding:
      position: 103
      prefix: --fastq
  - id: format
    type:
      - 'null'
      - boolean
    doc: File format version
    inputBinding:
      position: 103
      prefix: --format
  - id: ids
    type:
      - 'null'
      - boolean
    doc: Sequence ids (accession numbers)
    inputBinding:
      position: 103
      prefix: --ids
  - id: lengths
    type:
      - 'null'
      - boolean
    doc: Sequence lengths
    inputBinding:
      position: 103
      prefix: --lengths
  - id: line_length
    type:
      - 'null'
      - int
    doc: Use lines of width N for FASTA output
    inputBinding:
      position: 103
      prefix: --line-length
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Masked region lengths
    inputBinding:
      position: 103
      prefix: --mask
  - id: names
    type:
      - 'null'
      - boolean
    doc: Full sequence names (including ids)
    inputBinding:
      position: 103
      prefix: --names
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: Ignore mask
    inputBinding:
      position: 103
      prefix: --no-mask
  - id: number
    type:
      - 'null'
      - boolean
    doc: Number of sequences
    inputBinding:
      position: 103
      prefix: --number
  - id: part_list
    type:
      - 'null'
      - boolean
    doc: List of parts
    inputBinding:
      position: 103
      prefix: --part-list
  - id: seq
    type:
      - 'null'
      - boolean
    doc: Continuous concatenated sequence
    inputBinding:
      position: 103
      prefix: --seq
  - id: sequences
    type:
      - 'null'
      - boolean
    doc: One sequence per line, no names
    inputBinding:
      position: 103
      prefix: --sequences
  - id: sizes
    type:
      - 'null'
      - boolean
    doc: Part sizes
    inputBinding:
      position: 103
      prefix: --sizes
  - id: title
    type:
      - 'null'
      - boolean
    doc: Dataset title
    inputBinding:
      position: 103
      prefix: --title
  - id: total_length
    type:
      - 'null'
      - boolean
    doc: Sum of sequence lengths
    inputBinding:
      position: 103
      prefix: --total-length
  - id: write_stdout
    type:
      - 'null'
      - boolean
    doc: Write to standard output
    inputBinding:
      position: 103
      prefix: -c
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Decompress into FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naf:1.3.0--h3c26d10_0
