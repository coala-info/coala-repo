cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasta-utils
  - rename
label: mgkit_fasta-utils_rename
doc: "Rename Sequence headers of FASTA file (adds a random suffix and an optional prefix)\n\nTool homepage:\
  \ https://github.com/frubino/mgkit"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug messages).
    inputBinding:
      position: 101
      prefix: -v
  - id: prefix
    type:
      - 'null'
      - string
    doc: Adds a prefix to the header
    inputBinding:
      position: 101
      prefix: -p
  - id: file_name
    type:
      - 'null'
      - boolean
    doc: Adds filename as prefix
    inputBinding:
      position: 101
      prefix: -f
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator for the elements of the new header
    inputBinding:
      position: 101
      prefix: -s
  - id: suffix_len
    type:
      - 'null'
      - int
    doc: Number of random characters to use (0<=x<=20)
    inputBinding:
      position: 101
      prefix: -l
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
    doc: FASTA file with renamed headers.
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
