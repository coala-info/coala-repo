cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_cov.py
label: wub_bam_cov.py
doc: "Produce refrence coverage table.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: Input BAM file.
    inputBinding:
      position: 1
  - id: min_alignment_quality
    type:
      - 'null'
      - int
    doc: Minimum alignment quality
    inputBinding:
      position: 102
      prefix: -q
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet and do not show progress bars.
    inputBinding:
      position: 102
      prefix: -Q
  - id: reference
    type: File
    doc: Reference fasta.
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: -f
  - id: region
    type:
      - 'null'
      - string
    doc: BAM region
    inputBinding:
      position: 102
      prefix: -c
  - id: output_tsv_path
    type:
      - 'null'
      - string
    doc: Output TSV (bam_cov.tsv).
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Output TSV
    outputBinding:
      glob: '${ return inputs.output_tsv_path ? inputs.output_tsv_path : "bam_cov.tsv"; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
