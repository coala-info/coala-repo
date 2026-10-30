cwlVersion: v1.2
class: CommandLineTool
baseCommand: transposed_vcf_to_vcf
label: usher_transposed_vcf_to_vcf
doc: 'transposed_vcf_to_vcf: converts a transposed VCF file back to a VCF file.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: vcf
  type: string
  doc: Output VCF file (in uncompressed or gzip-compressed .gz format)
  inputBinding:
    position: 101
    prefix: --vcf
- id: threads
  type:
  - 'null'
  - int
  doc: 'Number of threads to use when possible [DEFAULT uses all available cores,
    20 detected on this machine] [default: 20]'
  inputBinding:
    position: 101
    prefix: --threads
- id: reference
  type: File
  doc: Reference file
  inputBinding:
    position: 101
    prefix: --reference
- id: samples
  type:
  - 'null'
  - File
  doc: rename file
  inputBinding:
    position: 101
    prefix: --samples
- id: output_path
  type: File
  doc: Load transposed VCF
  inputBinding:
    position: 101
    prefix: --output_path
outputs:
- id: vcf_file
  type: File
  doc: Output file named by --vcf. Output VCF file (in uncompressed or gzip-compressed
    .gz format)
  outputBinding:
    glob: $(inputs.vcf)
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
stdout: transposed_vcf_to_vcf_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
