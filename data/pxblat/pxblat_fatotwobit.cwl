cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pxblat
  - fatotwobit
label: pxblat_fatotwobit
doc: "Convert DNA from fasta to 2bit format.\n\nTool homepage: https://pypi.org/project/pxblat/"
inputs:
  - id: infa
    type:
      type: array
      items: File
    doc: The fasta files
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
      prefix: --ignoreDups
  - id: long
    type:
      - 'null'
      - boolean
    doc: Use 64-bit offsets for index. Allow for twoBit to contain more than 4Gb
      of sequence.
    inputBinding:
      position: 102
      prefix: --long
  - id: nomask
    type:
      - 'null'
      - boolean
    doc: Ignore lower-case masking in fa file.
    inputBinding:
      position: 102
      prefix: --nomask
  - id: strip_version
    type:
      - 'null'
      - boolean
    doc: Strip off version number after '.' for GenBank accessions.
    inputBinding:
      position: 102
      prefix: --stripVersion
outputs:
  - id: out2bit
    type: File
    doc: The output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
