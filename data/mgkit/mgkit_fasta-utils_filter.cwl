cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasta-utils
  - filter
label: mgkit_fasta-utils_filter
doc: "Filters a FASTA file\n\nTool homepage: https://github.com/frubino/mgkit"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug messages).
    inputBinding:
      position: 101
      prefix: -v
  - id: len_gt
    type:
      - 'null'
      - int
    doc: Keeps sequences whose length is greater than (x>=1)
    inputBinding:
      position: 101
      prefix: --len-gt
  - id: len_lt
    type:
      - 'null'
      - int
    doc: Keeps sequences whose length is less than (x>=1)
    inputBinding:
      position: 101
      prefix: --len-lt
  - id: header_contains
    type:
      - 'null'
      - string
    doc: Keeps sequences whose header contains the string
    inputBinding:
      position: 101
      prefix: --header-contains
  - id: seq_pattern
    type:
      - 'null'
      - string
    doc: Keeps sequences that contains the string
    inputBinding:
      position: 101
      prefix: --seq-pattern
  - id: header_file
    type:
      - 'null'
      - File
    doc: Keep only sequences contained in file list
    inputBinding:
      position: 101
      prefix: -f
  - id: wrap
    type:
      - 'null'
      - boolean
    doc: Wraps the output sequences to 60 characters
    inputBinding:
      position: 101
      prefix: -w
  - id: trim_tail
    type:
      - 'null'
      - boolean
    doc: Removes header information after first space
    inputBinding:
      position: 101
      prefix: -s
  - id: fasta_file
    type: File
    doc: Input FASTA file.
    inputBinding:
      position: 102
  - id: output_file
    type: string
    doc: Output file name (written instead of standard output).
    inputBinding:
      position: 103
outputs:
  - id: output
    type: File
    doc: Filtered FASTA file.
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
