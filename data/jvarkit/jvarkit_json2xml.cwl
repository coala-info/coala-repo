cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit_json2xml
label: jvarkit_json2xml
doc: "A tool to convert JSON data to XML format. (Note: The provided help text contains
  a system error message regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_json2xml.out
