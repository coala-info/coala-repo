cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - BiopetFlagstat
label: biopet_tool_BiopetFlagstat
doc: "Compute flag statistics for a BAM file.\n\nTool homepage: https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_file
    type: File
    doc: input bam file
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: output_file
    type:
      - 'null'
      - string
    doc: output file
    inputBinding:
      position: 101
      prefix: --outputFile
  - id: summary_file
    type:
      - 'null'
      - string
    doc: summary output file
    inputBinding:
      position: 101
      prefix: --summaryFile
  - id: region
    type:
      - 'null'
      - string
    doc: Region to count, as chr:start-stop
    inputBinding:
      position: 101
      prefix: --region
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
  - id: flagstat
    type:
      - 'null'
      - File
    doc: Flagstat report
    outputBinding:
      glob: '$(inputs.output_file ? inputs.output_file : [])'
  - id: summary
    type:
      - 'null'
      - File
    doc: Flagstat summary JSON
    outputBinding:
      glob: '$(inputs.summary_file ? inputs.summary_file : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_BiopetFlagstat.out
