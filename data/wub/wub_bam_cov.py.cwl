cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_cov.py
label: wub_bam_cov.py
doc: "Produce refrence coverage table.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: bam
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 1
  - id: min_alignment_quality
    type:
      - 'null'
      - int
    doc: Minimum alignment quality
    default: 0
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
    inputBinding:
      position: 102
      prefix: -f
  - id: region
    type:
      - 'null'
      - string
    doc: BAM region
    default: None
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Output TSV
    outputBinding:
      glob: $(inputs.output_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
