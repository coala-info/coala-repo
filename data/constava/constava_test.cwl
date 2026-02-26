cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - constava
  - test
label: constava_test
doc: "The `constava test` submodule runs a couple of test cases to check, if consistent
  results are achieved. This should be done once after installation and takes about
  a minute.\n\nTool homepage: https://github.com/bio2byte/constava"
inputs:
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Set verbosity level of screen output. Flag can be given multiple times 
      (up to 2) to gradually increase output to debugging mode.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
stdout: constava_test.out
