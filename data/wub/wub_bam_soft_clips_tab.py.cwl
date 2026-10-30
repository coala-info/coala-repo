cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_soft_clips_tab.py
label: wub_bam_soft_clips_tab.py
doc: 'Produce a tab separated file with read identifiers and number of soft clipped
  bases at each end (relative to the original sequence in the fastq).


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: bam
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 1
  - id: tsv
    type: string
    doc: Output tab separated file.
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
outputs:
  - id: soft_clips_tsv
    type: File
    doc: Read identifiers with soft clipped base counts at each end.
    outputBinding:
      glob: $(inputs.tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
