cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nf-test, init]
label: nf-test_init
doc: "Initialize an nf-test project: create nf-test.config and the tests directory in the working directory\n\nTool homepage: https://code.askimed.com/nf-test/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: log
    type: ['null', string]
    doc: "Filename for log file (default: .nf-test.log)"
    inputBinding:
      position: 1
      prefix: --log
  - id: silent
    type: ['null', boolean]
    doc: Hide header and program version
    inputBinding:
      position: 1
      prefix: --silent
outputs:
  - id: nf_test_config
    type: File
    doc: The nf-test project configuration
    outputBinding:
      glob: nf-test.config
  - id: tests_dir
    type: Directory
    doc: The tests directory
    outputBinding:
      glob: tests
  - id: stdout
    type: stdout
    doc: Standard output
stdout: nf-test_init.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-test:0.9.4--h2a3209d_0
