cwlVersion: v1.2
class: CommandLineTool
baseCommand: transpose_vcf
label: usher_transpose_vcf
doc: 'transpose_vcf: converts a VCF file (optionally renaming samples) into the transposed
  VCF format used by matOptimize.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: vcf
  type:
  - 'null'
  - File
  doc: Input VCF file (in uncompressed or gzip-compressed .gz format)
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
- id: output_path
  type:
  - 'null'
  - string
  doc: Save transposed VCF
  inputBinding:
    position: 101
    prefix: --output_path
- id: input_path
  type:
  - 'null'
  - File
  doc: Input transposed VCF for renaming
  inputBinding:
    position: 101
    prefix: --input_path
- id: rename_file
  type:
  - 'null'
  - File
  doc: Input 2 column tsv for renaming
  inputBinding:
    position: 101
    prefix: --rename_file
- id: filter
  type:
  - 'null'
  - boolean
  doc: remove samples not in rename file
  inputBinding:
    position: 101
    prefix: --filter
outputs:
- id: output_path_file
  type:
  - 'null'
  - File
  doc: Output file named by --output_path. Save transposed VCF
  outputBinding:
    glob: '${ return inputs.output_path ? inputs.output_path : []; }'
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
stdout: transpose_vcf_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
