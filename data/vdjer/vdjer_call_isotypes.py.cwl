cwlVersion: v1.2
class: CommandLineTool
baseCommand: vdjer_call_isotypes.py
label: vdjer_call_isotypes.py
doc: "A tool for calling isotypes (Note: The provided help text contains only container
  execution error logs and does not list usage or arguments).\n\nTool homepage: https://github.com/mozack/vdjer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vdjer:0.12--h43eeafb_7
stdout: vdjer_call_isotypes.py.out
