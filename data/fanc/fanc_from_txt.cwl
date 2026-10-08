cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - from-txt
label: fanc_from_txt
doc: "Import a Hi-C object from a sparse matrix txt format.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: contacts
    type: File
    doc: "Contacts file in sparse matrix format (<bin1><tab><bin2><tab><weight>)."
    inputBinding:
      position: 1
  - id: regions
    type: File
    doc: "Genomic regions (BED), optionally with the bin index used in the contacts file."
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "Output FAN-C Hic file."
    inputBinding:
      position: 3
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: hic
    type: File
    doc: "FAN-C Hic object."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
