cwlVersion: v1.2
class: CommandLineTool
baseCommand: oc
label: open-cravat_oc
doc: "Open-CRAVAT genomic variant interpreter. https://github.com/KarchinLab/open-cravat\n\
  \nTool homepage: http://www.opencravat.org"
inputs:
  - id: command
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - boolean
    doc: View and change configuration settings
    inputBinding:
      position: 102
      prefix: config
  - id: feedback
    type:
      - 'null'
      - boolean
    doc: Send feedback to the developers
    inputBinding:
      position: 102
      prefix: feedback
  - id: gui
    type:
      - 'null'
      - boolean
    doc: Start the GUI
    inputBinding:
      position: 102
      prefix: gui
  - id: module
    type:
      - 'null'
      - boolean
    doc: Change installed modules
    inputBinding:
      position: 102
      prefix: module
  - id: new
    type:
      - 'null'
      - boolean
    doc: Create new modules
    inputBinding:
      position: 102
      prefix: new
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate a report from a job
    inputBinding:
      position: 102
      prefix: report
  - id: run
    type:
      - 'null'
      - boolean
    doc: Run a job
    inputBinding:
      position: 102
      prefix: run
  - id: store
    type:
      - 'null'
      - boolean
    doc: Publish modules to the store
    inputBinding:
      position: 102
      prefix: store
  - id: util
    type:
      - 'null'
      - boolean
    doc: Utilities
    inputBinding:
      position: 102
      prefix: util
  - id: vcfanno
    type:
      - 'null'
      - boolean
    doc: annotate a vcf
    inputBinding:
      position: 102
      prefix: vcfanno
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/open-cravat:2.16.0--pyhdfd78af_0
stdout: open-cravat_oc.out
