cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_score_filter.py
label: wub_bam_score_filter.py
doc: 'Filter SAM/BAM records by score or other criteria. WARNING: the input records
  must be sorted by name or the filtering will not work as expected.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_file
    type: File
    doc: Input file.
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Output SAM file.
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: Input/output format (SAM).
    inputBinding:
      position: 103
      prefix: -f
  - id: strategy
    type:
      - 'null'
      - string
    doc: 'Filtering strategy: top_per_query, query_coverage, ref_coverage (top_per_query).'
    inputBinding:
      position: 103
      prefix: -s
  - id: query_cover
    type:
      - 'null'
      - float
    doc: Minimum query coverage fraction (0.8).
    inputBinding:
      position: 103
      prefix: -q
outputs:
  - id: output_sam
    type: File
    doc: Filtered SAM file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
