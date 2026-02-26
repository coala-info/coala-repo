cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio-rnaseq summarize
label: bcbio-rnaseq_summarize
doc: "Summarize RNA-Seq analysis results from a bcbio project.\n\nTool homepage: https://github.com/hbc/bcbioRNASeq"
inputs:
  - id: project_file
    type: File
    doc: bcbio project configuration file (YAML format)
    inputBinding:
      position: 1
  - id: formula
    type:
      - 'null'
      - string
    doc: 'Formula to use in model (example: ~ batch + condition)'
    inputBinding:
      position: 102
      prefix: --formula
  - id: organism
    type:
      - 'null'
      - string
    doc: organism (mouse, human)
    inputBinding:
      position: 102
      prefix: --organism
  - id: run_dexseq
    type:
      - 'null'
      - boolean
    doc: Run DEXSeq analysis
    inputBinding:
      position: 102
      prefix: --dexseq
  - id: run_sleuth
    type:
      - 'null'
      - boolean
    doc: Run Sleuth analysis
    inputBinding:
      position: 102
      prefix: --sleuth
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-rnaseq:1.2.0--r3.3.2_3
stdout: bcbio-rnaseq_summarize.out
