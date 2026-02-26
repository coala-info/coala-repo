cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vispr
  - test
label: vispr_test
doc: "Run vispr tests\n\nTool homepage: https://bitbucket.org/liulab/vispr"
inputs:
  - id: host
    type:
      - 'null'
      - string
    doc: Host to connect to
    inputBinding:
      position: 101
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: Port to connect to
    inputBinding:
      position: 101
      prefix: --port
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update test data
    inputBinding:
      position: 101
      prefix: --update
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
stdout: vispr_test.out
