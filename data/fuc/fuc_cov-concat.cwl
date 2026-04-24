cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc_cov-concat
label: fuc_cov-concat
doc: "Concatenate depth of coverage files.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: tsv_files
    type:
      type: array
      items: File
    doc: Input TSV files.
    inputBinding:
      position: 1
  - id: axis
    type:
      - 'null'
      - int
    doc: "The axis to concatenate along (default: 0) (choices:\n              0, 1
      where 0 is index and 1 is columns)."
    inputBinding:
      position: 102
      prefix: --axis
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_cov-concat.out
