cwlVersion: v1.2
class: CommandLineTool
baseCommand: drep_dRep
label: drep_dRep check_dependencies
doc: "Check dependencies for dRep\n\nTool homepage: https://github.com/MrOlm/drep"
inputs:
  - id: ANIcalculator
    type:
      - 'null'
      - boolean
    doc: ANIcalculator !!! ERROR !!!
    default: false
    inputBinding:
      position: 101
  - id: centrifuge
    type:
      - 'null'
      - boolean
    doc: centrifuge !!! ERROR !!!
    default: false
    inputBinding:
      position: 101
  - id: checkm
    type:
      - 'null'
      - boolean
    doc: checkm all good
    default: true
    inputBinding:
      position: 101
  - id: fastANI
    type:
      - 'null'
      - boolean
    doc: fastANI all good
    default: true
    inputBinding:
      position: 101
  - id: mash
    type:
      - 'null'
      - boolean
    doc: mash all good
    default: true
    inputBinding:
      position: 101
  - id: nsimscan
    type:
      - 'null'
      - boolean
    doc: nsimscan !!! ERROR !!!
    default: false
    inputBinding:
      position: 101
  - id: nucmer
    type:
      - 'null'
      - boolean
    doc: nucmer all good
    default: true
    inputBinding:
      position: 101
  - id: prodigal
    type:
      - 'null'
      - boolean
    doc: prodigal all good
    default: true
    inputBinding:
      position: 101
  - id: skani
    type:
      - 'null'
      - boolean
    doc: skani all good
    default: true
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drep:3.6.2--pyhdfd78af_0
stdout: drep_dRep check_dependencies.out
