cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - SageCountFastq
label: biopet_tool_SageCountFastq
doc: "Count the occurrence of each read sequence in a SAGE FASTQ file.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: input
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Output count file
    inputBinding:
      position: 101
      prefix: --output
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
  - id: counts
    type: File
    doc: Tag counts
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
