cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc_cov-rename
label: fuc_cov-rename
doc: "Rename the samples in a depth of coverage file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: tsv
    type: File
    doc: TSV file (compressed or uncompressed).
    inputBinding:
      position: 1
  - id: names
    type: File
    doc: Text file containing information for renaming the samples.
    inputBinding:
      position: 2
  - id: mode
    type:
      - 'null'
      - string
    doc: "Renaming mode (default: 'MAP') (choices: 'MAP', 'INDEX', 'RANGE')."
    default: MAP
    inputBinding:
      position: 103
      prefix: --mode
  - id: range
    type:
      - 'null'
      - type: array
        items: int
    doc: Index range to use when renaming the samples. Applicable only with the 
      'RANGE' mode.
    inputBinding:
      position: 103
      prefix: --range
  - id: sep
    type:
      - 'null'
      - string
    doc: "Delimiter to use when reading the names file (default: '\\t')."
    default: \t
    inputBinding:
      position: 103
      prefix: --sep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_cov-rename.out
