cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymlst_configure
label: pymlst_configure
doc: "Configure executables paths and log level.\n\nTool homepage: https://github.com/bvalot/pyMLST.git"
inputs:
  - id: blat
    type:
      - 'null'
      - File
    doc: Blat executable absolute path.
    inputBinding:
      position: 101
      prefix: --blat
  - id: kma
    type:
      - 'null'
      - File
    doc: Kma executable absolute path.
    inputBinding:
      position: 101
      prefix: --kma
  - id: log
    type:
      - 'null'
      - string
    doc: Level of logging, default=INFO
    inputBinding:
      position: 101
      prefix: --log
  - id: mafft
    type:
      - 'null'
      - File
    doc: Mafft executable absolute path.
    inputBinding:
      position: 101
      prefix: --mafft
  - id: reset
    type:
      - 'null'
      - boolean
    doc: Reset the configuration.
    inputBinding:
      position: 101
      prefix: --reset
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_configure.out
