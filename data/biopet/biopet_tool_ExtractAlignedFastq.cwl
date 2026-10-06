cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - ExtractAlignedFastq
label: biopet_tool_ExtractAlignedFastq
doc: "Select FASTQ records whose reads map to the given alignment intervals.\n\nTool homepage:\
  \ https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_file
    type: File
    doc: Input BAM file
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --input_file
  - id: interval
    type:
      type: array
      items: string
      inputBinding:
        prefix: --interval
    doc: Interval strings (e.g. chr1:1-100)
    inputBinding:
      position: 101
  - id: in1
    type: File
    doc: Input FASTQ file 1
    inputBinding:
      position: 101
      prefix: --in1
  - id: in2
    type:
      - 'null'
      - File
    doc: 'Input FASTQ file 2 (default: none)'
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
    type:
      - 'null'
      - string
    doc: 'Output FASTQ file 2 (default: none)'
    inputBinding:
      position: 101
      prefix: --out2
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'Minimum MAPQ of reads in target region to remove (default: 0)'
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: read_suffix_length
    type:
      - 'null'
      - int
    doc: 'Length of suffix mark from each read pair (default: 0)'
    inputBinding:
      position: 101
      prefix: --read_suffix_length
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
  - id: out1_fastq
    type: File
    doc: Output FASTQ file 1
    outputBinding:
      glob: $(inputs.out1)
  - id: out2_fastq
    type:
      - 'null'
      - File
    doc: Output FASTQ file 2
    outputBinding:
      glob: '$(inputs.out2 ? inputs.out2 : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
