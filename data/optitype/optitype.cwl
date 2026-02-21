cwlVersion: v1.2
class: CommandLineTool
baseCommand: optitype
label: optitype
doc: "OptiType is a HLA typing tool. (Note: The provided text is a system error log
  and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/FRED-2/OptiType"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optitype:1.3.5--hdfd78af_3
stdout: optitype.out
