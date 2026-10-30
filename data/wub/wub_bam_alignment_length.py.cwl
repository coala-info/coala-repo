cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_alignment_length.py
label: wub_bam_alignment_length.py
doc: 'Produce a tab separated file of alignment lengths and other information. Rows
  are sorted by number of aligned reference bases unless the -x option is specified.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: bam
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 1
  - id: tsv_file
    type:
      - 'null'
      - string
    doc: Tab separated file to save alignment lengths (bam_alignment_length.tsv).
    default: bam_alignment_length.tsv
    inputBinding:
      position: 102
      prefix: -t
  - id: aqual
    type:
      - 'null'
      - int
    doc: Minimum alignment quality (0).
    inputBinding:
      position: 102
      prefix: -q
  - id: sort_by_read_bases
    type:
      - 'null'
      - boolean
    doc: Sort by number of read bases instead of number of aligned reference bases.
    inputBinding:
      position: 102
      prefix: -x
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet and do not print progress bar (False).
    inputBinding:
      position: 102
      prefix: -Q
outputs:
  - id: alignment_length_tsv
    type: File
    doc: Tab separated table of alignment lengths.
    outputBinding:
      glob: $(inputs.tsv_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
