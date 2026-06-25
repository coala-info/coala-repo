cwlVersion: v1.2
class: CommandLineTool
baseCommand: mark-nonconverted-reads.py
label: mark-nonconverted-reads_mark-nonconverted-reads.py
doc: "Mark nonconverted reads\n\nTool homepage: https://github.com/nebiolabs/mark-nonconverted-reads"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: Input bam or sam file (must end in .bam or .sam)
    inputBinding:
      position: 101
      prefix: --bam
  - id: c_count
    type:
      - 'null'
      - int
    doc: Minimum number of nonconverted Cs on a read to consider it nonconverted
    inputBinding:
      position: 101
      prefix: --c_count
  - id: flag_reads
    type:
      - 'null'
      - boolean
    doc: Set the 'Failing platform / vendor quality check flag
    inputBinding:
      position: 101
      prefix: --flag_reads
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Reference fasta file
    inputBinding:
      position: 101
      prefix: --reference
  - id: out_path
    type: string
    doc: Name for output sam file [default = stdout]
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Name for output sam file
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mark-nonconverted-reads:1.2--pyhdfd78af_0
