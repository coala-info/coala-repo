cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virprof
  - init-test
label: virprof_init-test
doc: "Set up a demo/test directory\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: path
    type: Directory
    doc: Path to set up the demo/test directory
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite if directory exists
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
stdout: virprof_init-test.out
