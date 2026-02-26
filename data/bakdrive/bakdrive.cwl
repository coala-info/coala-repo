cwlVersion: v1.2
class: CommandLineTool
baseCommand: bakdrive
label: bakdrive
doc: "Bacterial interaction inference using MICOM, Driver nodes detection using MDSM,
  After-FMT community construction and simulation following the GLV model, Afte-driver
  species transplantation (ADT) community consturction and simulation following the
  GLV model, After-FMT or ADT simulation following the GLV model\n\nTool homepage:
  https://gitlab.com/treangenlab/bakdrive"
inputs:
  - id: sub_command
    type: string
    doc: sub-command help
    inputBinding:
      position: 1
  - id: driver
    type:
      - 'null'
      - boolean
    doc: Driver nodes detection using MDSM
    inputBinding:
      position: 102
  - id: fmt_donor
    type:
      - 'null'
      - boolean
    doc: "After-FMT community construction and simulation\nfollowing the GLV model"
    inputBinding:
      position: 102
  - id: fmt_driver
    type:
      - 'null'
      - boolean
    doc: "Afte-driver species transplantation (ADT) community\nconsturction and simulation
      following the GLV model"
    inputBinding:
      position: 102
  - id: fmt_only
    type:
      - 'null'
      - boolean
    doc: After-FMT or ADT simulation following the GLV model
    inputBinding:
      position: 102
  - id: interaction
    type:
      - 'null'
      - boolean
    doc: Bacterial interaction inference using MICOM
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
stdout: bakdrive.out
