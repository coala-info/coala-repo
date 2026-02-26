cwlVersion: v1.2
class: CommandLineTool
baseCommand: json_xs
label: perl-json-xs
doc: "The provided text is a Docker error message indicating a failure to pull the
  image due to lack of disk space. No help text or usage information was found in
  the input. Below is the standard structure for the 'json_xs' utility typically associated
  with this package.\n\nTool homepage: https://metacpan.org/pod/JSON::XS"
inputs:
  - id: eval_code
    type:
      - 'null'
      - string
    doc: Evaluate perl code after reading the input
    inputBinding:
      position: 101
      prefix: -e
  - id: input_format
    type:
      - 'null'
      - string
    doc: Read a file in the given format (json, cbrip, etc.)
    inputBinding:
      position: 101
      prefix: -f
  - id: output_format
    type:
      - 'null'
      - string
    doc: Write the file in the given format
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be more verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-json-xs:4.04--pl5321h9948957_0
stdout: perl-json-xs.out
