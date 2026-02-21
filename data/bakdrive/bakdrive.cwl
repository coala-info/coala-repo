cwlVersion: v1.2
class: CommandLineTool
baseCommand: bakdrive
label: bakdrive
doc: "A tool for bacterial genome analysis (Note: The provided text is an error log
  and does not contain usage information or argument definitions).\n\nTool homepage:
  https://gitlab.com/treangenlab/bakdrive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
stdout: bakdrive.out
