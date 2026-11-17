cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qsmxt
  - validate
label: qsmxt_validate
doc: "Validate a BIDS dataset for QSM processing: list the runs found (subject, session, echoes, field strength, echo times) and which outputs each can give, without processing anything.\n\nTool homepage: https://github.com/QSMxT/QSMxT"
inputs:
  - id: bids_dir
    type: Directory
    doc: Input BIDS directory.
    inputBinding:
      position: 101
  - id: include
    type:
      - 'null'
      - type: array
        items: string
    doc: Include only runs matching these glob patterns.
    inputBinding:
      position: 1
      prefix: --include
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude runs matching these glob patterns.
    inputBinding:
      position: 1
      prefix: --exclude
outputs:
  - id: report
    type: File
    doc: The validation report (runs found and what each supports).
    outputBinding:
      glob: qsmxt_validate.out
stdout: qsmxt_validate.out
stderr: qsmxt_validate.out
hints:
  - class: DockerRequirement
    dockerPull: vnmd/qsmxt_12.0.0:20261115
