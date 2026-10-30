cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_ref_tab.py
label: wub_bam_ref_tab.py
doc: 'Produce a tab separated file with read identifiers and the corresponding references,
  sorted by reference.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: bam
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 1
  - id: read_tsv
    type: string
    doc: Tab separated file to save reference table.
    inputBinding:
      position: 102
      prefix: -t
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet and do not print progress bar (False).
    inputBinding:
      position: 102
      prefix: -Q
  - id: save_strand
    type:
      - 'null'
      - boolean
    doc: Save read strand in output (False).
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: reference_tsv
    type: File
    doc: Table of read identifiers and the references they map to.
    outputBinding:
      glob: $(inputs.read_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
