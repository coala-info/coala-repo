cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AMAS.py
  - concat
label: amas_concat
doc: "Concatenate input alignments\n\nTool homepage: https://github.com/marekborowiec/AMAS"
inputs:
  - id: concat_part
    type: ['null', string]
    doc: "File name for the concatenated alignment partitions. Default: 'partitions.txt'"
    default: partitions.txt
    inputBinding:
      position: 1
      prefix: --concat-part
  - id: concat_out
    type: ['null', string]
    doc: "File name for the concatenated alignment. Default: 'concatenated.out'"
    default: concatenated.out
    inputBinding:
      position: 1
      prefix: --concat-out
  - id: out_format
    type: ['null', {type: enum, symbols: [fasta, phylip, nexus, phylip-int, nexus-int]}]
    doc: 'File format for the output alignment. Default: fasta'
    inputBinding:
      position: 1
      prefix: --out-format
  - id: part_format
    type: ['null', {type: enum, symbols: [nexus, raxml, unspecified]}]
    doc: "Format of the partitions file. Default: 'unspecified'"
    inputBinding:
      position: 1
      prefix: --part-format
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
  - id: concatenated_alignment
    type: File
    doc: Concatenated alignment
    outputBinding:
      glob: $(inputs.concat_out)
  - id: partitions
    type: File
    doc: Partitions of the concatenated alignment
    outputBinding:
      glob: $(inputs.concat_part)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
