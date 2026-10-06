cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - FindRepeatsPacBio
label: biopet_tool_FindRepeatsPacBio
doc: "Find repeat regions of a BED file in PacBio reads of a BAM file.\n\nTool homepage: https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_bam
    type: File
    doc: Path to input BAM file
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --inputBam
  - id: output_file
    type:
      - 'null'
      - string
    doc: Path to output file
    inputBinding:
      position: 101
      prefix: --outputFile
  - id: input_bed
    type: File
    doc: Path to bed file
    inputBinding:
      position: 101
      prefix: --inputBed
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
  - id: output
    type:
      - 'null'
      - File
    doc: Output table
    outputBinding:
      glob: '$(inputs.output_file ? inputs.output_file : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_FindRepeatsPacBio.out
