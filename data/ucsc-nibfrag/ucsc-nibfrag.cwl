cwlVersion: v1.2
class: CommandLineTool
baseCommand: nibFrag
label: ucsc-nibfrag
doc: Extract part of a nib file as .fa (all bases/gaps lower case by default)
inputs:
  - id: nib_file
    type: File
    doc: Input nib file
    inputBinding:
      position: 1
  - id: start
    type: int
    doc: Start position
    inputBinding:
      position: 2
  - id: end
    type: int
    doc: End position
    inputBinding:
      position: 3
  - id: strand
    type: string
    doc: 'Strand: + (plus) or m (minus)'
    inputBinding:
      position: 4
  - id: out_fa
    type: string
    doc: Output fasta file
    inputBinding:
      position: 5
  - id: masked
    type:
      - 'null'
      - boolean
    doc: Use lower-case characters for bases meant to be masked out.
    inputBinding:
      position: 106
      prefix: -masked
  - id: hard_masked
    type:
      - 'null'
      - boolean
    doc: Use upper-case for not masked-out, and 'N' characters for masked-out 
      bases.
    inputBinding:
      position: 106
      prefix: -hardMasked
  - id: upper
    type:
      - 'null'
      - boolean
    doc: Use upper-case characters for all bases.
    inputBinding:
      position: 106
      prefix: -upper
  - id: name
    type:
      - 'null'
      - string
    doc: Use given name after '>' in output sequence.
    inputBinding:
      position: 106
      prefix: -name=
      separate: false
  - id: db_header
    type:
      - 'null'
      - string
    doc: Add full database info to the header, with or without -name option.
    inputBinding:
      position: 106
      prefix: -dbHeader=
      separate: false
  - id: tba_header
    type:
      - 'null'
      - string
    doc: Format header for compatibility with tba, takes database name as 
      argument.
    inputBinding:
      position: 106
      prefix: -tbaHeader=
      separate: false
outputs:
  - id: out_out_fa
    type: File
    doc: Output fasta file
    outputBinding:
      glob: $(inputs.out_fa)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-nibfrag:482--h0b57e2e_0
s:url: https://hgdownload.cse.ucsc.edu/admin/exe
$namespaces:
  s: https://schema.org/
