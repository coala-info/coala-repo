cwlVersion: v1.2
class: CommandLineTool
baseCommand: ennaf
label: naf_ennaf
doc: "ennaf\n\nTool homepage: https://github.com/KirillKryukov/naf"
inputs:
  - id: infile
    type:
      - 'null'
      - File
    doc: Input file
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: 'Use compression level # (from -131072 to 22, default: 1)'
    default: 1
    inputBinding:
      position: 102
      prefix: --level
  - id: dataset_title
    type:
      - 'null'
      - string
    doc: Store TITLE as dataset title
    inputBinding:
      position: 102
      prefix: --title
  - id: input_dna
    type:
      - 'null'
      - boolean
    doc: Input sequence is DNA (default)
    default: true
    inputBinding:
      position: 102
      prefix: --dna
  - id: input_fasta
    type:
      - 'null'
      - boolean
    doc: Input is in FASTA format
    inputBinding:
      position: 102
      prefix: --fasta
  - id: input_fastq
    type:
      - 'null'
      - boolean
    doc: Input is in FASTQ format
    inputBinding:
      position: 102
      prefix: --fastq
  - id: input_protein
    type:
      - 'null'
      - boolean
    doc: Input sequence is protein
    inputBinding:
      position: 102
      prefix: --protein
  - id: input_rna
    type:
      - 'null'
      - boolean
    doc: Input sequence is RNA
    inputBinding:
      position: 102
      prefix: --rna
  - id: input_text
    type:
      - 'null'
      - boolean
    doc: Input sequence is text
    inputBinding:
      position: 102
      prefix: --text
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep temporary files
    inputBinding:
      position: 102
      prefix: --keep-temp-files
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: Don't store mask
    inputBinding:
      position: 102
      prefix: --no-mask
  - id: override_line_length
    type:
      - 'null'
      - int
    doc: Override line length to N
    inputBinding:
      position: 102
      prefix: --line-length
  - id: strict_input
    type:
      - 'null'
      - boolean
    doc: Fail on unexpected input characters
    inputBinding:
      position: 102
      prefix: --strict
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Use DIR as temporary directory
    inputBinding:
      position: 102
      prefix: --temp-dir
  - id: temp_name_prefix
    type:
      - 'null'
      - string
    doc: Use NAME as prefix for temporary files
    inputBinding:
      position: 102
      prefix: --name
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window_size_power
    type:
      - 'null'
      - int
    doc: Use window of size 2^N for sequence stream (from 10 to 31)
    inputBinding:
      position: 102
      prefix: --long
  - id: write_stdout
    type:
      - 'null'
      - boolean
    doc: Write to standard output
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write compressed output to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naf:1.3.0--h3c26d10_0
