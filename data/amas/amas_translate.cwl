cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AMAS.py
  - translate
label: amas_translate
doc: "Translate a protein-coding DNA alignment into amino acids\n\nTool homepage: https://github.com/marekborowiec/AMAS"
inputs:
  - id: code
    type: ['null', int]
    doc: 'NCBI genetic code to use (1, 2, 3, 4, 5, 6, 9, 10, 11, 12, 13, 14, 16, 21, 22, 23, 24, 25, 26). Default: 1.'
    inputBinding:
      position: 1
      prefix: --code
  - id: reading_frame
    type: ['null', int]
    doc: "Number specifying reading frame (1, 2 or 3); i.e. '2' means codons start at the second character of the alignment. Default: 1"
    inputBinding:
      position: 1
      prefix: --reading-frame
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
  - id: translated_alignments
    type: File[]
    doc: Translated alignments (translated_<input name><ext><ext>)
    outputBinding:
      glob: translated_*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
