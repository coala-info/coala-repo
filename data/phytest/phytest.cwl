cwlVersion: v1.2
class: CommandLineTool
baseCommand: phytest
label: phytest
doc: "A tool for testing phylogenetic data.\n\nTool homepage: https://github.com/phytest-devs/phytest"
inputs:
  - id: testfile
    type: File
    doc: The test file to be executed by phytest.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phytest:1.4.1--pyhdfd78af_0
stdout: phytest.out
