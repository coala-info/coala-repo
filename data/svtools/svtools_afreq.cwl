cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - afreq
label: svtools_afreq
doc: 'Add allele frequency information to a VCF file.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: input_vcf
    type: File
    doc: VCF input (optionally bgzipped). If no file is specified then input is read
      from stdin.
    inputBinding:
      position: 1
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
    type: stdout
    doc: VCF with allele frequency annotation
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_afreq.vcf
