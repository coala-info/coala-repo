cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-json-parse
label: perl-json-parse
doc: "A tool for parsing JSON. (Note: The provided input text contains system error
  messages regarding container image retrieval and disk space issues rather than the
  tool's help documentation.)\n\nTool homepage: http://metacpan.org/pod/JSON::Parse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-json-parse:0.62--pl5321h9948957_5
stdout: perl-json-parse.out
