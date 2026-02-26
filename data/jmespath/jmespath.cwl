cwlVersion: v1.2
class: CommandLineTool
baseCommand: jmespath
label: jmespath
doc: "JMESPath command line interface for querying JSON data.\n\nTool homepage: https://github.com/jmespath/jmespath.py"
inputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: The JSON file to query. If not provided, data is read from stdin.
    inputBinding:
      position: 1
  - id: expression
    type:
      - 'null'
      - string
    doc: The JMESPath expression to evaluate
    inputBinding:
      position: 102
      prefix: --expression
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jmespath:0.9.0--py36_0
stdout: jmespath.out
