cwlVersion: v1.2
class: CommandLineTool
baseCommand: argparse2tool
label: argparse2tool
doc: "A tool to convert argparse help text to CWL CommandLineTool.\n\nTool homepage:
  https://github.com/erasche/argparse2tool"
inputs:
  - id: input_file
    type: File
    doc: Path to the input file containing argparse help text.
    inputBinding:
      position: 1
  - id: base_command
    type:
      - 'null'
      - type: array
        items: string
    doc: The base command and subcommands for the tool.
    inputBinding:
      position: 102
      prefix: --base-command
  - id: description
    type:
      - 'null'
      - string
    doc: A description for the tool.
    inputBinding:
      position: 102
      prefix: --description
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output file if it already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: tool_name
    type:
      - 'null'
      - string
    doc: The name of the tool to be used in the CWL file.
    inputBinding:
      position: 102
      prefix: --tool-name
outputs:
  - id: output_cwl
    type:
      - 'null'
      - File
    doc: Path to the output CWL CommandLineTool file.
    outputBinding:
      glob: $(inputs.output_cwl)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/argparse2tool:0.5.2--pyhdfd78af_0
