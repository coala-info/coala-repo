cwlVersion: v1.2
class: CommandLineTool
baseCommand: jp.py
label: jmespath
doc: "JMESPath command line interface for querying JSON data. The program installed in the image is jp.py.\n\nTool homepage: https://github.com/jmespath/jmespath.py"
inputs:
  - id: expression
    type: string
    doc: The JMESPath expression to evaluate
    inputBinding:
      position: 2
  - id: filename
    type:
      - 'null'
      - File
    doc: The filename containing the input data. If a filename is not given then
      data is read from stdin.
    inputBinding:
      position: 1
      prefix: --filename
  - id: ast
    type:
      - 'null'
      - boolean
    doc: Pretty print the AST, do not search the data.
    inputBinding:
      position: 1
      prefix: --ast
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jmespath:0.9.0--py36_0
stdout: jmespath.out
