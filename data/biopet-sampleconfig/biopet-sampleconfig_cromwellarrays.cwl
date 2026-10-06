cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet-sampleconfig
  - cromwellarrays
label: biopet-sampleconfig_cromwellarrays
doc: "A tool to generate Cromwell arrays configuration from sample JSON or YAML files.\n\
  \ \nTool homepage: https://github.com/biopet/sampleconfig"
inputs:
  - id: input_file
    type:
      type: array
      items: File
      inputBinding:
        prefix: --inputFile
    doc: Input sample json / yml, can give multiple file
    inputBinding:
      position: 101
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: output_file_path
    type: string
    doc: ' Output file, if none given stdout is used'
    inputBinding:
      position: 102
      prefix: --outputFile
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, if none given stdout is used
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-sampleconfig:0.3--0
