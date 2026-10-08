cwlVersion: v1.2
class: CommandLineTool
baseCommand: compare-ddbj
label: gff3toddbj_compare-ddbj
doc: "Compare two DDBJ annotation files and report statistics on entries, features and locations.\n\nTool homepage: https://github.com/yamaton/gff3toddbj"
inputs:
  - id: no_rename_entry
    type:
      - 'null'
      - boolean
    doc: "Disable renaming of entries by extracting accession part assuming dbj|accession|locus format"
    inputBinding:
      position: 1
      prefix: --no-rename-entry
  - id: patch_features
    type:
      - 'null'
      - boolean
    doc: "Remove short (< 10bp) introns by patching feature gaps"
    inputBinding:
      position: 1
      prefix: --patch-features
  - id: log
    type:
      - 'null'
      - string
    doc: "[debug] Choose log level from (DEBUG, INFO, WARNING, ERROR) (default: INFO)."
    inputBinding:
      position: 1
      prefix: --log
  - id: ddbj1
    type: File
    doc: "Input DDBJ annotation 1"
    inputBinding:
      position: 2
  - id: ddbj2
    type: File
    doc: "Input DDBJ annotation 2"
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: "Comparison report"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
stdout: gff3toddbj_compare-ddbj.out
