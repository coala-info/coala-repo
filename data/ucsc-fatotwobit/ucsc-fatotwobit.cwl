cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToTwoBit
label: ucsc-fatotwobit
doc: "Convert DNA from fasta to 2bit format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type:
      type: array
      items: File
    doc: One or more input FASTA files
    inputBinding:
      position: 1
  - id: ignore_multi
    type:
      - 'null'
      - boolean
    doc: If there are multiple sequences in a fasta file, only use the first one.
    inputBinding:
      position: 102
      prefix: -ignoreMulti
  - id: long
    type:
      - 'null'
      - boolean
    doc: Use 64-bit offsets for index. Allow for two-bit files larger than 4Gb. This
      is not compatible with most other 2bit utilities.
    inputBinding:
      position: 102
      prefix: -long
  - id: no_check
    type:
      - 'null'
      - boolean
    doc: Skip checking for valid DNA characters.
    inputBinding:
      position: 102
      prefix: -noCheck
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: Ignore lower-case masking, make all sequence upper case.
    inputBinding:
      position: 102
      prefix: -noMask
  - id: strip_mask
    type:
      - 'null'
      - boolean
    doc: Remove masking, make all sequence upper case.
    inputBinding:
      position: 102
      prefix: -stripMask
outputs:
  - id: output_file
    type: File
    doc: Output 2bit file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatotwobit:482--hdc0a859_0
