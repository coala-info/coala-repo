cwlVersion: v1.2
class: CommandLineTool
baseCommand: transposed_vcf_print_name
label: usher_transposed_vcf_print_name
doc: 'transposed_vcf_print_name: prints the sample names stored in a transposed VCF
  file.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: transposed_vcf
  type: File
  doc: Transposed VCF file (made by transpose_vcf).
  inputBinding:
    position: 1
outputs:
- id: sample_names
  type: stdout
  doc: Sample names, one per line.
stdout: transposed_vcf_print_name_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
