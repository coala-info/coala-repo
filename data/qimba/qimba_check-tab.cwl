cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qimba
  - check-tab
label: qimba_check-tab
doc: "Check TSV files for their dimensions and consistency.\n\nTool homepage: https://github.com/quadram-institute-bioscience/qimba"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: TSV files to check
    inputBinding:
      position: 1
  - id: no_strict
    type:
      - 'null'
      - boolean
    doc: Do not strictly enforce consistent column counts
    inputBinding:
      position: 102
      prefix: --no-strict
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Strictly enforce consistent column counts
    inputBinding:
      position: 102
      prefix: --strict
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
stdout: qimba_check-tab.out
