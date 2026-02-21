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
    doc: Python expression to evaluate
    inputBinding:
      position: 1
  - id: import_module
    type:
      - 'null'
      - type: array
        items: string
    doc: Import a module before running the expression
    inputBinding:
      position: 102
      prefix: --import
  - id: list_output
    type:
      - 'null'
      - boolean
    doc: Iterate over the expression result and print each item on a new line
    inputBinding:
      position: 102
      prefix: --list
  - id: post_cmd
    type:
      - 'null'
      - string
    doc: Run code after evaluating the expression
    inputBinding:
      position: 102
      prefix: --post
  - id: pre_cmd
    type:
      - 'null'
      - string
    doc: Run code before evaluating the expression (e.g., imports)
    inputBinding:
      position: 102
      prefix: --pre
  - id: split
    type:
      - 'null'
      - boolean
    doc: Treat each line of standard input as 'x' and evaluate the expression for
      each line
    inputBinding:
      position: 102
      prefix: --split
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythonpy:0.4.11--py_0
stdout: pythonpy.out
