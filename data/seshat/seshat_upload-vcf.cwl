cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seshat
  - upload-vcf
label: seshat_upload-vcf
doc: 'Upload a VCF file to the Seshat batch annotation service. Needs the Seshat web service.


  Tool homepage: https://github.com/clintval/tp53'
inputs:
  - id: input_vcf
    type: File
    doc: The path to the input VCF file.
    inputBinding:
      position: 1
      prefix: --input
  - id: email
    type: string
    doc: The email address for delivering Seshat annotations.
    inputBinding:
      position: 2
      prefix: --email
  - id: url
    type:
      - 'null'
      - string
    doc: The Seshat batch annotation URL.
    inputBinding:
      position: 3
      prefix: --url
  - id: wait_for
    type:
      - 'null'
      - int
    doc: Seconds to wait before raising an exception. Default 200.
    inputBinding:
      position: 4
      prefix: --wait-for
  - id: assembly
    type:
      - 'null'
      - string
    doc: The human genome assembly of the input VCF (hg17, hg19, hg38). Default hg38.
    inputBinding:
      position: 5
      prefix: --assembly
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
stdout: seshat_upload-vcf.out
