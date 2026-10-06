cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - FastqSync
label: biopet_tool_FastqSync
doc: "Sync paired-end FASTQ files to a reference FASTQ.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: ref
    type: File
    doc: Reference FASTQ file
    inputBinding:
      position: 101
      prefix: --ref
  - id: in1
    type: File
    doc: Input FASTQ file 1
    inputBinding:
      position: 101
      prefix: --in1
  - id: in2
    type: File
    doc: Input FASTQ file 2
    inputBinding:
      position: 101
      prefix: --in2
  - id: out1
    type: string
    doc: Output FASTQ file 1
    inputBinding:
      position: 101
      prefix: --out1
  - id: out2
    type: string
    doc: Output FASTQ file 2
    inputBinding:
      position: 101
      prefix: --out2
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
  - id: out1_fastq
    type: File
    doc: Output FASTQ file 1
    outputBinding:
      glob: $(inputs.out1)
  - id: out2_fastq
    type: File
    doc: Output FASTQ file 2
    outputBinding:
      glob: $(inputs.out2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_FastqSync.out
