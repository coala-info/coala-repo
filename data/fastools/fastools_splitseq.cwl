cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - splitseq
label: fastools_splitseq
doc: "Split a FASTA/FASTQ file based on containing part of the sequence\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: output_with_seq
    type: string
    doc: output file for reads that contain the sequence
    inputBinding:
      position: 2
  - id: output_without_seq
    type: string
    doc: output file for reads that do not contain the sequence
    inputBinding:
      position: 3
  - id: seq
    type: string
    doc: a sequence (str)
    inputBinding:
      position: 4
outputs:
  - id: out_output_with_seq
    type:
      - 'null'
      - File
    doc: Reads containing the sequence.
    outputBinding:
      glob: $(inputs.output_with_seq)
  - id: out_output_without_seq
    type:
      - 'null'
      - File
    doc: Reads not containing the sequence.
    outputBinding:
      glob: $(inputs.output_without_seq)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
