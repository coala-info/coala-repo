cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - bedpetovcf
label: svtools_bedpetovcf
doc: 'Convert a BEDPE file to a VCF file.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: input_bedpe
    type: File
    doc: 'BEDPE input (default: stdin). The input BEDPE file can be gzipped if it
      is specified explicitly.'
    inputBinding:
      position: 101
      prefix: --input
  - id: output_vcf
    type: string
    doc: 'Output VCF to write (default: stdout)'
    inputBinding:
      position: 101
      prefix: --output
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Directory for temp file downloads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: out_vcf
    type: File
    doc: Output VCF
    outputBinding:
      glob: $(inputs.output_vcf)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
