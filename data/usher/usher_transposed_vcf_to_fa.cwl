cwlVersion: v1.2
class: CommandLineTool
baseCommand: transposed_vcf_to_fa
label: usher_transposed_vcf_to_fa
doc: 'transposed_vcf_to_fa: converts a transposed VCF file to a FASTA file.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: fa
  type: string
  doc: Output FASTA file (in uncompressed or gzip-compressed .gz format)
  inputBinding:
    position: 101
    prefix: --fa
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
- id: fa_file
  type: File
  doc: Output file named by --fa. Output FASTA file (in uncompressed or gzip-compressed
    .gz format)
  outputBinding:
    glob: $(inputs.fa)
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
stdout: transposed_vcf_to_fa_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
