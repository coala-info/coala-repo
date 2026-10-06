cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - FindOverlapMatch
label: biopet_tool_FindOverlapMatch
doc: "Report sample pairs in an overlap table whose value passes a cutoff.\n\nTool homepage:\
  \ https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: Input should be a table where the first row and column have the ID's, those can be
      different
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type:
      - 'null'
      - string
    doc: Output file, default to stdout
    inputBinding:
      position: 101
      prefix: --output
  - id: cutoff
    type: double
    doc: minimum value to report it as pair
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: use_same_names
    type:
      - 'null'
      - boolean
    doc: Do not compare samples with the same name
    inputBinding:
      position: 101
      prefix: --use_same_names
  - id: row_sample_regex
    type:
      - 'null'
      - string
    doc: Samples in the row should match this regex
    inputBinding:
      position: 101
      prefix: --rowSampleRegex
  - id: column_sample_regex
    type:
      - 'null'
      - string
    doc: Samples in the column should match this regex
    inputBinding:
      position: 101
      prefix: --columnSampleRegex
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
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: '$(inputs.output ? inputs.output : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_FindOverlapMatch.out
