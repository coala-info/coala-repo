cwlVersion: v1.2
class: CommandLineTool
baseCommand: jq
label: jq
doc: "jq is a lightweight and flexible command-line JSON processor.\n\nTool homepage:
  https://github.com/jquery/jquery"
inputs:
  - id: filter
    type: string
    doc: The filter to apply to the JSON input (e.g., '.')
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: JSON files to process. If not specified, jq reads from stdin.
    inputBinding:
      position: 2
  - id: arg
    type:
      - 'null'
      - type: array
        items: string
    doc: Pass a value to the jq program as a predefined variable ($name).
    inputBinding:
      position: 103
      prefix: --arg
  - id: argjson
    type:
      - 'null'
      - type: array
        items: string
    doc: Pass a JSON-encoded value to the jq program as a predefined variable.
    inputBinding:
      position: 103
      prefix: --argjson
  - id: compact_output
    type:
      - 'null'
      - boolean
    doc: Output each JSON object on a single line.
    inputBinding:
      position: 103
      prefix: --compact-output
  - id: null_input
    type:
      - 'null'
      - boolean
    doc: Don't read any input at all; the filter is run once with null as the input.
    inputBinding:
      position: 103
      prefix: --null-input
  - id: raw_input
    type:
      - 'null'
      - boolean
    doc: Don't parse the input as JSON; treat each line of text as a string.
    inputBinding:
      position: 103
      prefix: --raw-input
  - id: raw_output
    type:
      - 'null'
      - boolean
    doc: If the filter's result is a string, write it directly to stdout rather than
      as a JSON string.
    inputBinding:
      position: 103
      prefix: --raw-output
  - id: slurp
    type:
      - 'null'
      - boolean
    doc: Read the entire input stream into a large array and run the filter just once.
    inputBinding:
      position: 103
      prefix: --slurp
  - id: slurpfile
    type:
      - 'null'
      - type: array
        items: File
    doc: Read all JSON objects from a file and bind them to a variable.
    inputBinding:
      position: 103
      prefix: --slurpfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jq:1.6
stdout: jq.out
