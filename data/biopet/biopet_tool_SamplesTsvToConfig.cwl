cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - SamplesTsvToConfig
label: biopet_tool_SamplesTsvToConfig
doc: "Convert sample/library TSV files to a Biopet sample config (yaml or json).\n\nTool homepage:\
  \ https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --inputFiles
    doc: Input tsv files; first line is the header and must at least have a 'sample' column,
      'library' column is optional
    inputBinding:
      position: 101
  - id: tag_files
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --tagFiles
    doc: Tag tsv files
    inputBinding:
      position: 101
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file; .yml/.yaml gives yaml, otherwise json; stdout as yaml when not given
    inputBinding:
      position: 101
      prefix: --outputFile
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
  - id: config
    type:
      - 'null'
      - File
    doc: Sample config file
    outputBinding:
      glob: '$(inputs.output_file ? inputs.output_file : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_SamplesTsvToConfig.out
