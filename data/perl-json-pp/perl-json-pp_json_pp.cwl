cwlVersion: v1.2
class: CommandLineTool
baseCommand: json_pp
label: perl-json-pp_json_pp
doc: "A command-line utility to convert between different JSON formats and pretty-print
  JSON data. It typically reads from STDIN and writes to STDOUT.\n\nTool homepage:
  http://metacpan.org/pod/JSON::PP"
inputs:
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format (e.g., json, eval, yaml)
    inputBinding:
      position: 101
      prefix: -f
  - id: json_opt
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for JSON::PP (e.g., pretty, ascii)
    inputBinding:
      position: 101
      prefix: -json_opt
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format (e.g., json, eval)
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-json-pp:4.11--pl5321hdfd78af_0
stdout: perl-json-pp_json_pp.out
