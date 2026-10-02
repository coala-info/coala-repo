cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/jq
label: jq
doc: jq is a tool for processing JSON inputs, applying the given filter to its 
  JSON text inputs and producing the filter's results as JSON on standard 
  output.
inputs:
  - id: filter
    type: string
    doc: jq filter to apply
    inputBinding:
      position: 1
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: JSON input file(s)
    inputBinding:
      position: 2
  - id: compact_output
    type:
      - 'null'
      - boolean
    doc: compact instead of pretty-printed output
    inputBinding:
      position: 103
      prefix: -c
  - id: null_input
    type:
      - 'null'
      - boolean
    doc: use `null` as the single input value
    inputBinding:
      position: 103
      prefix: -n
  - id: exit_status
    type:
      - 'null'
      - boolean
    doc: set the exit status code based on the output
    inputBinding:
      position: 103
      prefix: -e
  - id: slurp
    type:
      - 'null'
      - boolean
    doc: read (slurp) all inputs into an array; apply filter to it
    inputBinding:
      position: 103
      prefix: -s
  - id: raw_output
    type:
      - 'null'
      - boolean
    doc: output raw strings, not JSON texts
    inputBinding:
      position: 103
      prefix: -r
  - id: raw_input
    type:
      - 'null'
      - boolean
    doc: read raw strings, not JSON texts
    inputBinding:
      position: 103
      prefix: -R
  - id: color_output
    type:
      - 'null'
      - boolean
    doc: colorize JSON
    inputBinding:
      position: 103
      prefix: -C
  - id: monochrome_output
    type:
      - 'null'
      - boolean
    doc: monochrome (don't colorize JSON)
    inputBinding:
      position: 103
      prefix: -M
  - id: sort_keys
    type:
      - 'null'
      - boolean
    doc: sort keys of objects on output
    inputBinding:
      position: 103
      prefix: -S
  - id: tab
    type:
      - 'null'
      - boolean
    doc: use tabs for indentation
    inputBinding:
      position: 103
      prefix: --tab
  - id: arg
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --arg
          separate: true
    doc: set variable $a to value <v>
    inputBinding:
      position: 103
  - id: argjson
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --argjson
          separate: true
    doc: set variable $a to JSON value <v>
    inputBinding:
      position: 103
  - id: slurpfile
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --slurpfile
          separate: true
    doc: set variable $a to an array of JSON texts read from <f>
    inputBinding:
      position: 103
  - id: rawfile
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --rawfile
          separate: true
    doc: set variable $a to a string consisting of the contents of <f>
    inputBinding:
      position: 103
  - id: args
    type:
      - 'null'
      - boolean
    doc: remaining arguments are string arguments, not files
    inputBinding:
      position: 103
      prefix: --args
  - id: jsonargs
    type:
      - 'null'
      - boolean
    doc: remaining arguments are JSON arguments, not files
    inputBinding:
      position: 103
      prefix: --jsonargs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jq:1.6
stdout: jq.out
s:url: https://github.com/jquery/jquery
$namespaces:
  s: https://schema.org/
