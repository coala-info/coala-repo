cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToTwoBit
label: ucsc-fatotwobit
doc: Convert DNA from fasta to 2bit format
inputs:
  - id: in_fa
    type:
      type: array
      items: File
    doc: Input FASTA file(s)
    inputBinding:
      position: 1
  - id: out_2bit
    type: string
    doc: Output 2bit file
    inputBinding:
      position: 2
  - id: long
    type:
      - 'null'
      - boolean
    doc: use 64-bit offsets for index. Allow for twoBit to contain more than 4Gb
      of sequence. NOT COMPATIBLE WITH OLDER CODE.
    inputBinding:
      position: 103
      prefix: -long
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: Ignore lower-case masking in fa file.
    inputBinding:
      position: 103
      prefix: -noMask
  - id: strip_version
    type:
      - 'null'
      - boolean
    doc: Strip off version number after '.' for GenBank accessions.
    inputBinding:
      position: 103
      prefix: -stripVersion
  - id: ignore_dups
    type:
      - 'null'
      - boolean
    doc: Convert first sequence only if there are duplicate sequence names. Use 
      'twoBitDup' to find duplicate sequences.
    inputBinding:
      position: 103
      prefix: -ignoreDups
  - id: name_prefix
    type:
      - 'null'
      - string
    doc: add XX. to start of sequence name in 2bit.
    inputBinding:
      position: 103
      prefix: -namePrefix=
      separate: false
outputs:
  - id: out_out_2bit
    type: File
    doc: Output 2bit file
    outputBinding:
      glob: $(inputs.out_2bit)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatotwobit:482--hdc0a859_0
s:url: https://hgdownload.cse.ucsc.edu/admin/exe
$namespaces:
  s: https://schema.org/
