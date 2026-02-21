cwlVersion: v1.2
class: CommandLineTool
baseCommand: iow_bp
label: iow_bp
doc: "The provided text contains container execution error logs rather than tool help
  documentation. No arguments or descriptions could be extracted from the input.\n
  \nTool homepage: https://github.com/biocore/improved-octo-waddle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iow:1.0.8--py310h1fe012e_1
stdout: iow_bp.out
