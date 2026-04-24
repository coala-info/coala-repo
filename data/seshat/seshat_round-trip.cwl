cwlVersion: v1.2
class: CommandLineTool
baseCommand: seshat_round-trip
label: seshat_round-trip
doc: "Seshat round-trip annotation tool\n\nTool homepage: https://github.com/clintval/tp53"
inputs:
  - id: annotation_type
    type:
      - 'null'
      - string
    doc: 'The annotation text file output from Seshat. Available options: (short,
      long).'
    inputBinding:
      position: 101
      prefix: --annotation-type
  - id: assembly
    type:
      - 'null'
      - string
    doc: 'The human genome assembly of the input VCF. Available options: (hg17, hg19,
      hg38).'
    inputBinding:
      position: 101
      prefix: --assembly
  - id: credentials
    type:
      - 'null'
      - File
    doc: The Google OAuth credentials JSON.
    inputBinding:
      position: 101
      prefix: --credentials
  - id: email
    type: string
    doc: The email address for delivering Seshat annotations.
    inputBinding:
      position: 101
      prefix: --email
  - id: input_vcf
    type: File
    doc: The path to the input VCF file.
    inputBinding:
      position: 101
      prefix: --input
  - id: newer_than_email
    type:
      - 'null'
      - int
    doc: Only consider emails that arrived <= hours.
    inputBinding:
      position: 101
      prefix: --newer-than-email
  - id: output_prefix
    type: string
    doc: The output path prefix for the annotations and annotated VCF.
    inputBinding:
      position: 101
      prefix: --output
  - id: seshat_url
    type:
      - 'null'
      - string
    doc: The Seshat batch annotation URL.
    inputBinding:
      position: 101
      prefix: --url
  - id: wait_for_email
    type:
      - 'null'
      - int
    doc: How long to wait for Seshat to email in seconds.
    inputBinding:
      position: 101
      prefix: --wait-for-email
  - id: wait_for_upload
    type:
      - 'null'
      - int
    doc: Seconds to wait before raising an exception.
    inputBinding:
      position: 101
      prefix: --wait-for-upload
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
stdout: seshat_round-trip.out
