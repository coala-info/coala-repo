cwlVersion: v1.2
class: CommandLineTool
baseCommand: danpos.py
label: danpos_danpos.py
doc: "The provided text contains system logs and a fatal error message regarding a
  lack of disk space during a container build; it does not contain the help text or
  usage information for danpos_danpos.py. As a result, no arguments could be extracted
  from the input.\n\nTool homepage: https://sites.google.com/site/danposdoc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/danpos:v2.2.2_cv3
stdout: danpos_danpos.py.out
