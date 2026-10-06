cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - ValidateFastq
label: biopet_tool_ValidateFastq
doc: "Validate one FASTQ file or a pair of FASTQ files.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: fastq1
    type: File
    doc: FASTQ file (read 1)
    inputBinding:
      position: 101
      prefix: --fastq1
  - id: fastq2
    type:
      - 'null'
      - File
    doc: FASTQ file (read 2)
    inputBinding:
      position: 101
      prefix: --fastq2
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
  - id: stderr
    type: stderr
    doc: Standard error (log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_ValidateFastq.out
stderr: biopet_tool_ValidateFastq.log
