cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - renameseq
label: bioformats_renameseq
doc: "Change sequence names in a FASTA or plain text tabular file.\n\nTool homepage:
  https://github.com/gtamazian/bioformats"
inputs:
  - id: renaming_table
    type: File
    doc: a file containing a table of original and new sequence names
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: a file to change sequence names in
    inputBinding:
      position: 2
  - id: column
    type:
      - 'null'
      - int
    doc: the number of the column that contains sequence names to be changed staring
      from 1
    inputBinding:
      position: 103
      prefix: --column
  - id: comment_char
    type:
      - 'null'
      - string
    doc: a character that designates comment lines in the specified plain-text file
    inputBinding:
      position: 103
      prefix: --comment_char
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: the input file is of the FASTA format
    inputBinding:
      position: 103
      prefix: --fasta
  - id: no_description
    type:
      - 'null'
      - boolean
    doc: remove descriptions from FASTA sequence names
    inputBinding:
      position: 103
      prefix: --no_description
  - id: revert
    type:
      - 'null'
      - boolean
    doc: perform reverse renaming, that is, change original and new names in the renaming
      table
    inputBinding:
      position: 103
      prefix: --revert
  - id: separator
    type:
      - 'null'
      - string
    doc: a symbol that separates columns in the specified plain-text file
    inputBinding:
      position: 103
      prefix: --separator
outputs:
  - id: output_file
    type: File
    doc: an output file with renamed sequences
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
