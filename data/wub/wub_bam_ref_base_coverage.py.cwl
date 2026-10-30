cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_ref_base_coverage.py
label: wub_bam_ref_base_coverage.py
doc: 'Calculate percent covered reference lengths.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: bam
    type: File
    doc: Input BAM file.
    secondaryFiles:
      - .bai
    inputBinding:
      position: 1
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
    doc: BAM region (None).
    inputBinding:
      position: 102
      prefix: -c
  - id: tsv
    type:
      - 'null'
      - string
    doc: Output tab separated file (bam_ref_base_coverage.tsv).
    default: bam_ref_base_coverage.tsv
    inputBinding:
      position: 102
      prefix: -t
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum base coverage for a position to be counted (1).
    inputBinding:
      position: 102
      prefix: -m
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet and do not show progress bars.
    inputBinding:
      position: 102
      prefix: -Q
outputs:
  - id: coverage_tsv
    type: File
    doc: Percent covered reference length table.
    outputBinding:
      glob: $(inputs.tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
