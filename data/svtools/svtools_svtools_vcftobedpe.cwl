cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - vcftobedpe
label: svtools_svtools_vcftobedpe
doc: 'Convert a VCF file to a BEDPE file


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: input_vcf
    type: File
    doc: 'VCF input (default: stdin). The input VCF file can be gzipped if it is specified
      explicitly.'
    inputBinding:
      position: 101
      prefix: --input
  - id: output_bedpe
    type: string
    doc: 'output BEDPE to write (default: stdout)'
    inputBinding:
      position: 101
      prefix: --output
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Directory for temp file downloads
    inputBinding:
      position: 101
      prefix: --tempdir
outputs:
  - id: out_bedpe
    type: File
    doc: Output BEDPE
    outputBinding:
      glob: $(inputs.output_bedpe)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
