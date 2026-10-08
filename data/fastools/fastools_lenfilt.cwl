cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - lenfilt
label: fastools_lenfilt
doc: "Split a FASTA/FASTQ file on length.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: output_long
    type: string
    doc: output file for records with at least the threshold length
    inputBinding:
      position: 2
  - id: output_short
    type: string
    doc: output file for records shorter than the threshold length
    inputBinding:
      position: 3
  - id: length
    type:
      - 'null'
      - int
    doc: "length threshold (int default: 25)"
    inputBinding:
      position: 4
      prefix: -l
outputs:
  - id: out_output_long
    type:
      - 'null'
      - File
    doc: Records at least as long as the threshold.
    outputBinding:
      glob: $(inputs.output_long)
  - id: out_output_short
    type:
      - 'null'
      - File
    doc: Records shorter than the threshold.
    outputBinding:
      glob: $(inputs.output_short)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
