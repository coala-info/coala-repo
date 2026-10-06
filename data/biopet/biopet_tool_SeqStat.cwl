cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - SeqStat
label: biopet_tool_SeqStat
doc: "Summarize a FASTQ file (base and quality statistics) as JSON.\n\nTool homepage: https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: fastq
    type: File
    doc: FastQ file to generate stats from
    inputBinding:
      position: 101
      prefix: --fastq
  - id: output
    type:
      - 'null'
      - string
    doc: File to write output to, if not supplied output go to stdout
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
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_json
    type:
      - 'null'
      - File
    doc: Statistics JSON
    outputBinding:
      glob: '$(inputs.output ? inputs.output : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_SeqStat.out
