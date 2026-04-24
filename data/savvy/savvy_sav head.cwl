cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sav
  - head
label: savvy_sav head
doc: "Print headers or sample IDs from a Savvy file\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: input_sav
    type: File
    doc: Input Savvy file
    inputBinding:
      position: 1
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Specifies output format for header lines (vcf or tsv; default: tsv)'
    inputBinding:
      position: 102
      prefix: --output-format
  - id: sample_ids
    type:
      - 'null'
      - boolean
    doc: Print samples ids instead of headers
    inputBinding:
      position: 102
      prefix: --sample-ids
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
stdout: savvy_sav head.out
