cwlVersion: v1.2
class: CommandLineTool
baseCommand: wdltool_inputs
label: wdltool_inputs
doc: "Generate JSON inputs for a WDL workflow.\n\nTool homepage: https://github.com/broadinstitute/wdltool"
inputs:
  - id: wdl_file
    type: File
    doc: Path to the WDL file
    inputBinding:
      position: 1
  - id: inputs_json
    type:
      - 'null'
      - File
    doc: Path to a JSON file containing input values
    inputBinding:
      position: 102
      prefix: --inputs
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: Show all inputs, including those with defaults
    inputBinding:
      position: 102
      prefix: --show-all
  - id: show_defaults
    type:
      - 'null'
      - boolean
    doc: Show default values for inputs
    inputBinding:
      position: 102
      prefix: --show-defaults
  - id: show_descriptions
    type:
      - 'null'
      - boolean
    doc: Show input descriptions
    inputBinding:
      position: 102
      prefix: --show-descriptions
  - id: show_optional
    type:
      - 'null'
      - boolean
    doc: Show only optional inputs
    inputBinding:
      position: 102
      prefix: --show-optional
  - id: show_required
    type:
      - 'null'
      - boolean
    doc: Show only required inputs
    inputBinding:
      position: 102
      prefix: --show-required
  - id: show_types
    type:
      - 'null'
      - boolean
    doc: Show input types
    inputBinding:
      position: 102
      prefix: --show-types
  - id: output_json_path
    type: string
    doc: Output or path parameter `output_json_path`
    inputBinding:
      position: 103
      prefix: --output-json
outputs:
  - id: output_json
    type:
      - 'null'
      - File
    doc: Path to the output JSON file (defaults to stdout)
    outputBinding:
      glob: $(inputs.output_json_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wdltool:0.14--1
