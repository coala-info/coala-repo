cwlVersion: v1.2
class: CommandLineTool
baseCommand: ixIxx
label: makehub_ixIxx
doc: "Create indices for simple line-oriented file of format <symbol> <free text>\n\
  \nTool homepage: https://github.com/Gaius-Augustus/MakeHub"
inputs:
  - id: input_text_file
    type: File
    doc: Input text file
    inputBinding:
      position: 1
  - id: output_word_index
    type: File
    doc: Output word index file
    inputBinding:
      position: 2
  - id: output_index_into_index
    type: File
    doc: Output index into the index file
    inputBinding:
      position: 3
  - id: bin_size
    type:
      - 'null'
      - string
    doc: Size of bins in ixx.
    default: 64k
    inputBinding:
      position: 104
      prefix: -binSize
  - id: max_word_length
    type:
      - 'null'
      - int
    doc: Maximum allowed word length. Words with more characters than this limit
      are ignored and will not appear in index or be searchable.
    default: 31
    inputBinding:
      position: 104
      prefix: -maxWordLength
  - id: prefix_size
    type:
      - 'null'
      - int
    doc: Size of prefix to index on in ixx.
    default: 5
    inputBinding:
      position: 104
      prefix: -prefixSize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/makehub:1.0.8--hdfd78af_1
stdout: makehub_ixIxx.out
