cwlVersion: v1.2
class: CommandLineTool
baseCommand: seshat_upload-vcf
label: seshat_upload-vcf
doc: "Uploads a VCF file to Seshat for annotation.\n\nTool homepage: https://github.com/clintval/tp53"
inputs:
  - id: assembly
    type:
      - 'null'
      - string
    doc: 'The human genome assembly of the input VCF. Available options: (hg17, hg19,
      hg38).'
    inputBinding:
      position: 101
      prefix: --assembly
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
  - id: url
    type:
      - 'null'
      - string
    doc: The Seshat batch annotation URL.
    inputBinding:
      position: 101
      prefix: --url
  - id: wait_for
    type:
      - 'null'
      - int
    doc: Seconds to wait before raising an exception.
    inputBinding:
      position: 101
      prefix: --wait-for
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
stdout: seshat_upload-vcf.out
