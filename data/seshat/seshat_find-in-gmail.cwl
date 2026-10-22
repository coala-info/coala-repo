cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seshat
  - find-in-gmail
label: seshat_find-in-gmail
doc: 'Find the Seshat annotation email in Gmail and download the annotations. Needs a Gmail account and Google OAuth credentials.


  Tool homepage: https://github.com/clintval/tp53'
inputs:
  - id: input_vcf
    type: File
    doc: The path to the input VCF file.
    inputBinding:
      position: 1
      prefix: --input
  - id: output_prefix_path
    type: string
    doc: The output path prefix for writing annotations.
    inputBinding:
      position: 2
      prefix: --output
  - id: credentials
    type:
      - 'null'
      - File
    doc: The Google OAuth credentials JSON.
    inputBinding:
      position: 3
      prefix: --credentials
  - id: newer_than
    type:
      - 'null'
      - int
    doc: Only consider emails that arrived <= hours. Default 10.
    inputBinding:
      position: 4
      prefix: --newer-than
  - id: wait_for
    type:
      - 'null'
      - int
    doc: How long to wait for Seshat to email in seconds. Default 200.
    inputBinding:
      position: 5
      prefix: --wait-for
outputs:
  - id: annotations
    type:
      type: array
      items: File
    doc: Annotation files written with the output prefix.
    outputBinding:
      glob: $(inputs.output_prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
