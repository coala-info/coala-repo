cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToTwoBit
label: comparative-annotation-toolkit_faToTwoBit
doc: "Convert DNA from fasta to 2bit format\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/Comparative-Annotation-Toolkit"
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
  - id: long_offsets
    type:
      - 'null'
      - boolean
    doc: use 64-bit offsets for index. Allow for twoBit to contain more than 4Gb
      of sequence. NOT COMPATIBLE WITH OLDER CODE.
    inputBinding:
      position: 102
      prefix: -long
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
outputs:
  - id: output_file
    type: File
    doc: Output 2bit file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/comparative-annotation-toolkit:0.1--pyh2407274_1
