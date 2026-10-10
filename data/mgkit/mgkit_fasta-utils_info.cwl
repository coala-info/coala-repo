cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasta-utils
  - info
label: mgkit_fasta-utils_info
doc: "Gets information of FASTA file\n\nTool homepage: https://github.com/frubino/mgkit"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug messages).
    inputBinding:
      position: 101
      prefix: -v
  - id: header
    type:
      - 'null'
      - boolean
    doc: Prints header
    inputBinding:
      position: 101
      prefix: -h
  - id: include_seq
    type:
      - 'null'
      - boolean
    doc: Includes the sequence
    inputBinding:
      position: 101
      prefix: -s
  - id: no_rename
    type:
      - 'null'
      - boolean
    doc: Do not split sequence name at first space
    inputBinding:
      position: 101
      prefix: -r
  - id: hash_type
    type:
      - 'null'
      - string
    doc: 'Hash type: sha1, md5 or sha256 (default: sha1)'
    inputBinding:
      position: 101
      prefix: -a
  - id: out_gff
    type:
      - 'null'
      - boolean
    doc: Outputs a GFF file
    inputBinding:
      position: 101
      prefix: -g
  - id: gc_content
    type:
      - 'null'
      - boolean
    doc: Includes the GC Content
    inputBinding:
      position: 101
      prefix: -gc
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
    doc: Sequence information table.
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
