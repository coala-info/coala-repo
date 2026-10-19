cwlVersion: v1.2
class: CommandLineTool
baseCommand: py
label: pythonpy
doc: "pythonpy - python on the command line. It allows you to execute python expressions
  directly in the shell, often used for processing text or performing quick calculations.\n
  \nTool homepage: https://github.com/Russell91/pythonpy"
inputs:
  - id: expression
    type:
      - 'null'
      - string
    doc: Python expression to evaluate, e.g. py '2 ** 32'
    inputBinding:
      position: 100
  - id: stdin_file
    type:
      - 'null'
      - File
    doc: File sent to the standard input of py (used by -x and -l, or read by the
      expression)
  - id: each_row
    type:
      - 'null'
      - boolean
    doc: treat each row of stdin as x
    inputBinding:
      position: 1
      prefix: -x
  - id: list_stdin
    type:
      - 'null'
      - boolean
    doc: treat list of stdin as l
    inputBinding:
      position: 1
      prefix: -l
  - id: pre_cmd
    type:
      - 'null'
      - string
    doc: run code before expression
    inputBinding:
      position: 1
      prefix: -c
  - id: post_cmd
    type:
      - 'null'
      - string
    doc: run code after expression
    inputBinding:
      position: 1
      prefix: -C
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythonpy:0.4.11--py_0
stdin: $(inputs.stdin_file.path)
stdout: pythonpy.out
