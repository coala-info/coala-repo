cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - abritamr
  - report
label: abritamr_report
doc: "Generate reports for abritamr results\n\nTool homepage: https://github.com/MDU-PHL/abritamr"
inputs:
  - id: matches
    type:
      - 'null'
      - File
    doc: Path to matches, concatentated output of abritamr
    inputBinding:
      position: 101
      prefix: --matches
  - id: partials
    type:
      - 'null'
      - File
    doc: Path to partial matches, concatentated output of abritamr
    inputBinding:
      position: 101
      prefix: --partials
  - id: qc
    type:
      - 'null'
      - File
    doc: Name of checked MDU QC file.
    inputBinding:
      position: 101
      prefix: --qc
  - id: runid
    type:
      - 'null'
      - string
    doc: MDU RunID
    inputBinding:
      position: 101
      prefix: --runid
  - id: sop
    type:
      - 'null'
      - string
    doc: 'The pipeline for reporting results. Options: general, plus'
    inputBinding:
      position: 101
      prefix: --sop
  - id: sop_name
    type:
      - 'null'
      - string
    doc: The name of the process - will be reflected in the names od the output 
      files.
    inputBinding:
      position: 101
      prefix: --sop_name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abritamr:1.0.20--pyh5707d69_0
stdout: abritamr_report.out
