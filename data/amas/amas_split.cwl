cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AMAS.py
  - split
label: amas_split
doc: "Split alignment according to a partitions file\n\nTool homepage: https://github.com/marekborowiec/AMAS"
inputs:
  - id: split_by
    type: File
    doc: 'File name for partitions to be used for alignment splitting.'
    inputBinding:
      position: 1
      prefix: --split-by
  - id: remove_empty
    type: ['null', boolean]
    doc: "Remove taxa with sequences composed of only undetermined characters? Default: Don't remove"
    inputBinding:
      position: 1
      prefix: --remove-empty
  - id: out_format
    type: ['null', {type: enum, symbols: [fasta, phylip, nexus, phylip-int, nexus-int]}]
    doc: 'File format for the output alignment. Default: fasta'
    inputBinding:
      position: 1
      prefix: --out-format
  - id: check_align
    type: ['null', boolean]
    doc: 'Check if input sequences are aligned. Default: no check'
    inputBinding:
      position: 1
      prefix: --check-align
  - id: cores
    type: ['null', int]
    doc: 'Number of cores used. Default: 1'
    inputBinding:
      position: 1
      prefix: --cores
  - id: in_files
    type: File[]
    doc: 'Alignment files to be taken as input'
    inputBinding:
      position: 1
      prefix: --in-files
  - id: in_format
    type: {type: enum, symbols: [fasta, phylip, nexus, phylip-int, nexus-int]}
    doc: 'The format of input alignment'
    inputBinding:
      position: 1
      prefix: --in-format
  - id: data_type
    type: {type: enum, symbols: [aa, dna]}
    doc: 'Type of data'
    inputBinding:
      position: 1
      prefix: --data-type
outputs:
  - id: split_alignments
    type: File[]
    doc: 'One alignment per partition (<input name>_<partition>-out.<ext>)'
    outputBinding:
      glob: '*-out.*'
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.in_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
