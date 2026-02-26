cwlVersion: v1.2
class: CommandLineTool
baseCommand: philosopher report
label: philosopher_report
doc: "Generate reports from philosopher runs.\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: decoys
    type:
      - 'null'
      - boolean
    doc: add decoy observations to reports
    inputBinding:
      position: 101
      prefix: --decoys
  - id: ionmobility
    type:
      - 'null'
      - boolean
    doc: forces the printing of the ion mobility column
    inputBinding:
      position: 101
      prefix: --ionmobility
  - id: msstats
    type:
      - 'null'
      - boolean
    doc: create an output compatible with MSstats
    inputBinding:
      position: 101
      prefix: --msstats
  - id: mzid
    type:
      - 'null'
      - boolean
    doc: create a mzID output
    inputBinding:
      position: 101
      prefix: --mzid
  - id: prefix
    type:
      - 'null'
      - boolean
    doc: add the project (folder) name as a prefix to the output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: removecontam
    type:
      - 'null'
      - boolean
    doc: remove contaminant sequences from the reports
    inputBinding:
      position: 101
      prefix: --removecontam
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_report.out
