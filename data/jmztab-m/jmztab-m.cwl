cwlVersion: v1.2
class: CommandLineTool
baseCommand: jmztabm-cli
label: jmztab-m
doc: "Command-line interface for mzTab validation and conversion.\n\nTool homepage:
  https://github.com/lifs-tools/jmztab-m"
inputs:
  - id: check_file
    type:
      - 'null'
      - File
    doc: Check and validate the provided a mzTab file.
    inputBinding:
      position: 101
      prefix: --check
  - id: check_semantic_file
    type:
      - 'null'
      - File
    doc: Use the provided mapping file for semantic validation. If no mapping 
      file is provided, the default one will be used. Requires an active 
      internet connection!
    inputBinding:
      position: 101
      prefix: --checkSemantic
  - id: from_json
    type:
      - 'null'
      - boolean
    doc: Will parse inFile as JSON and write mzTab representation to disk. 
      Requires validation to be successful!
    inputBinding:
      position: 101
      prefix: --fromJson
  - id: message_detail
    type:
      - 'null'
      - int
    doc: Print validation message detail information based on error code.
    inputBinding:
      position: 101
      prefix: --message
  - id: to_json
    type:
      - 'null'
      - boolean
    doc: Will write a json representation of inFile to disk. Requires validation
      to be successful!
    inputBinding:
      position: 101
      prefix: --toJson
  - id: validation_level
    type:
      - 'null'
      - string
    doc: Choose validation level (Info, Warn, Error), default level is Info!
    default: Info
    inputBinding:
      position: 101
      prefix: --level
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Record validation messages into outfile. If not set, print validation 
      messages to stdout/stderr.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jmztab-m:1.0.6--hdfd78af_1
