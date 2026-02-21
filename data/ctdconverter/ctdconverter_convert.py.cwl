cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctdconverter_convert.py
label: ctdconverter_convert.py
doc: "A tool for converting CTD (Common Tool Description) files into other formats
  (such as Galaxy tool XML or CWL). Note: The provided help text contains only system
  error messages regarding a container build failure and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/WorkflowConversion/CTDConverter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ctdconverter:v2.0-4-deb_cv1
stdout: ctdconverter_convert.py.out
