cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosight
label: chromosight_test
doc: "Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact
  maps with pattern matching.\n\nTool homepage: https://github.com/koszullab/chromosight"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Displays the logo.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
stdout: chromosight_test.out
