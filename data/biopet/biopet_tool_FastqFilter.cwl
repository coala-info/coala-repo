cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - FastqFilter
label: biopet_tool_FastqFilter
doc: "Filter FASTQ records by read ID regex.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: input_file
    type: File
    doc: Path to input file
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: output
    type: string
    doc: Path to output file
    inputBinding:
      position: 101
      prefix: --output
  - id: id_regex
    type:
      - 'null'
      - string
    doc: Regex to match ID
    inputBinding:
      position: 101
      prefix: --idRegex
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
    doc: Filtered FASTQ file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
