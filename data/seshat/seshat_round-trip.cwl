cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seshat
  - round-trip
label: seshat_round-trip
doc: 'Upload a VCF to Seshat, wait for the annotation email in Gmail, and merge the annotations into the VCF. Needs the Seshat web service and a Gmail account.


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
    doc: The output path prefix for the annotations and annotated VCF.
    inputBinding:
      position: 2
      prefix: --output
  - id: email
    type: string
    doc: The email address for delivering Seshat annotations.
    inputBinding:
      position: 3
      prefix: --email
  - id: assembly
    type:
      - 'null'
      - string
    doc: The human genome assembly of the input VCF (hg17, hg19, hg38). Default hg38.
    inputBinding:
      position: 4
      prefix: --assembly
  - id: annotation_type
    type:
      - 'null'
      - string
    doc: The annotation text file type (short, long). Default long.
    inputBinding:
      position: 5
      prefix: --annotation-type
  - id: url
    type:
      - 'null'
      - string
    doc: The Seshat batch annotation URL.
    inputBinding:
      position: 6
      prefix: --url
  - id: wait_for_upload
    type:
      - 'null'
      - int
    doc: Seconds to wait before raising an exception. Default 200.
    inputBinding:
      position: 7
      prefix: --wait-for-upload
  - id: wait_for_email
    type:
      - 'null'
      - int
    doc: How long to wait for Seshat to email in seconds. Default 200.
    inputBinding:
      position: 8
      prefix: --wait-for-email
  - id: newer_than_email
    type:
      - 'null'
      - int
    doc: Only consider emails that arrived <= hours. Default 10.
    inputBinding:
      position: 9
      prefix: --newer-than-email
  - id: credentials
    type:
      - 'null'
      - File
    doc: The Google OAuth credentials JSON.
    inputBinding:
      position: 10
      prefix: --credentials
outputs:
  - id: round_trip_files
    type:
      type: array
      items: File
    doc: Annotation and annotated VCF files written with the output prefix.
    outputBinding:
      glob: $(inputs.output_prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
