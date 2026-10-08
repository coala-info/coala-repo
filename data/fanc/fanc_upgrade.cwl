cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - upgrade
label: fanc_upgrade
doc: "Upgrade FAN-C objects from old FAN-C versions.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: hic
    type: File
    doc: "Hic object to be upgraded."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output file."
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force upgrade even if object can be loaded."
    inputBinding:
      position: 20
      prefix: --force
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: upgraded
    type: File
    doc: "Upgraded object."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.hic)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
