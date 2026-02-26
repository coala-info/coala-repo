cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToTwoBit
label: kegalign-full_faToTwoBit
doc: "Convert DNA from fasta to 2bit format\n\nTool homepage: https://github.com/galaxyproject/KegAlign"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA files
    inputBinding:
      position: 1
  - id: ignore_dups
    type:
      - 'null'
      - boolean
    doc: Convert first sequence only if there are duplicate sequence names. Use 
      'twoBitDup' to find duplicate sequences.
    inputBinding:
      position: 102
      prefix: -ignoreDups
  - id: name_prefix
    type:
      - 'null'
      - string
    doc: add XX. to start of sequence name in 2bit.
    inputBinding:
      position: 102
      prefix: -namePrefix
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: Ignore lower-case masking in fa file.
    inputBinding:
      position: 102
      prefix: -noMask
  - id: strip_version
    type:
      - 'null'
      - boolean
    doc: Strip off version number after '.' for GenBank accessions.
    inputBinding:
      position: 102
      prefix: -stripVersion
  - id: use_long_offsets
    type:
      - 'null'
      - boolean
    doc: use 64-bit offsets for index. Allow for twoBit to contain more than 4Gb
      of sequence. NOT COMPATIBLE WITH OLDER CODE.
    inputBinding:
      position: 102
      prefix: -long
outputs:
  - id: output_file
    type: File
    doc: Output 2bit file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
