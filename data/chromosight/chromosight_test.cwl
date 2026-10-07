cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chromosight
  - test
label: chromosight_test
doc: "Download example data and run loop detection on it.\n\nTool homepage: https://github.com/koszullab/chromosight"
requirements:
  - class: NetworkAccess
    networkAccess: true
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
  - id: test_files
    type:
      type: array
      items: File
    doc: Loop detection results on the example data (chromosight_test.tsv, 
      chromosight_test.json)
    outputBinding:
      glob:
        - chromosight_test.tsv
        - chromosight_test.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
stdout: chromosight_test.out
