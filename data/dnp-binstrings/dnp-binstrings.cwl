cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-binstrings
label: dnp-binstrings
doc: "A tool for processing binary strings (Note: The provided help text contains
  only container runtime error messages and does not list specific command-line arguments).\n
  \nTool homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-binstrings:1.0--hd6d6fdc_6
stdout: dnp-binstrings.out
