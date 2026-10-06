cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - PrefixFastq
label: biopet_tool_PrefixFastq
doc: "Add a prefix sequence to every read of a FASTQ file.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: input
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Output FASTQ file
    inputBinding:
      position: 101
      prefix: --output
  - id: seq
    type: string
    doc: Prefix sequence
    inputBinding:
      position: 101
      prefix: --seq
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output_fastq
    type: File
    doc: Prefixed FASTQ file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
