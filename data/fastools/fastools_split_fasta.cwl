cwlVersion: v1.2
class: CommandLineTool
baseCommand: split_fasta
label: fastools_split_fasta
doc: "Split a FASTA file based on the occurrence of markers. The output is FASTA-like, depending on the replacement defined in the library. Per marker, two files are created: markername.txt (all sequences that have the marker as substring) and markername_counted.txt (unique sequences, with counts in the header). Format of the library file: name marker replacement.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: library
    type: File
    doc: file containing markers
    inputBinding:
      position: 2
  - id: output
    type:
      - 'null'
      - string
    doc: output file (default=stdout)
    inputBinding:
      position: 3
      prefix: -o
outputs:
  - id: marker_files
    type:
      type: array
      items: File
    doc: Per marker, the sequences with the marker and the counted unique sequences.
    outputBinding:
      glob: '*.txt'
  - id: summary
    type:
      - 'null'
      - File
    doc: Summary output file.
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_split_fasta.out
