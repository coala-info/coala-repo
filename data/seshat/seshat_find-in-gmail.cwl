cwlVersion: v1.2
class: CommandLineTool
baseCommand: seshat_find-in-gmail
label: seshat_find-in-gmail
doc: "Finds emails in Gmail and annotates them.\n\nTool homepage: https://github.com/clintval/tp53"
inputs:
  - id: credentials
    type:
      - 'null'
      - string
    doc: The Google OAuth credentials JSON.
    inputBinding:
      position: 101
      prefix: --credentials
  - id: input_vcf
    type: File
    doc: The path to the input VCF file.
    inputBinding:
      position: 101
      prefix: --input
  - id: newer_than_hours
    type:
      - 'null'
      - int
    doc: Only consider emails that arrived <= hours.
    inputBinding:
      position: 101
      prefix: --newer-than
  - id: wait_for_seconds
    type:
      - 'null'
      - int
    doc: How long to wait for Seshat to email in seconds.
    inputBinding:
      position: 101
      prefix: --wait-for
outputs:
  - id: output_prefix
    type: File
    doc: The output path prefix for writing annotations.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
