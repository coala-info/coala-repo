cwlVersion: v1.2
class: CommandLineTool
baseCommand: processFragOut.py
label: transgenescan_processFragOut.py
doc: "A script to process fragment output, likely part of the TransGeneScan suite.
  (Note: The provided help text contains only execution error messages and does not
  list specific arguments or usage instructions.)\n\nTool homepage: https://github.com/COL-IU/TransGeneScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transgenescan:1.3.0--h7b50bb2_3
stdout: transgenescan_processFragOut.py.out
