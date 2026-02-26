cwlVersion: v1.2
class: CommandLineTool
baseCommand: hed
label: homoeditdistance_hed
doc: "Given two strings, find their homo-edit distance\n\nTool homepage: https://github.com/AlBi-HHU/homo-edit-distance"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: show all optimal subsequences
    inputBinding:
      position: 101
      prefix: --all
  - id: backtrace
    type:
      - 'null'
      - boolean
    doc: print transformation steps
    inputBinding:
      position: 101
      prefix: --backtrace
  - id: string1
    type: string
    doc: first string. Use quotation marks around your string (e.g. "STRING")for
      the empty string or strings with special characters
    inputBinding:
      position: 101
      prefix: --string1
  - id: string2
    type: string
    doc: second string
    inputBinding:
      position: 101
      prefix: --string2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homoeditdistance:0.0.1--py_0
stdout: homoeditdistance_hed.out
