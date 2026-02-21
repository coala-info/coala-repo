cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctdconverter
label: ctdconverter
doc: "A tool for converting CTD (Common Tool Description) files into other formats
  such as Galaxy XML or CWL. (Note: The provided help text appears to be a system
  error log regarding a container build failure and does not contain command-line
  argument definitions).\n\nTool homepage: https://github.com/WorkflowConversion/CTDConverter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ctdconverter:v2.0-4-deb_cv1
stdout: ctdconverter.out
