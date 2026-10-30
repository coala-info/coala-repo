cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_alignments_compare.py
label: wub_bam_alignments_compare.py
doc: 'Compare alignments stored in two BAM files. The two BAM files must have the
  same set of reads in the same order (name sorted).


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: bam_one
    type: File
    doc: First input BAM file.
    inputBinding:
      position: 1
  - id: bam_two
    type: File
    doc: Second input BAM file.
    inputBinding:
      position: 2
  - id: coarse_tolerance
    type:
      - 'null'
      - int
    doc: Tolerance when performing coarse comparison of alignments (50).
    inputBinding:
      position: 103
      prefix: -w
  - id: strict_flags
    type:
      - 'null'
      - boolean
    doc: Do strict comparison of alignment flags.
    inputBinding:
      position: 103
      prefix: -g
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: Report PDF (bam_alignments_compare.pdf).
    default: bam_alignments_compare.pdf
    inputBinding:
      position: 103
      prefix: -r
  - id: results_pickle
    type:
      - 'null'
      - string
    doc: Save pickled results in this file (bam_alignments_compare.pk).
    default: bam_alignments_compare.pk
    inputBinding:
      position: 103
      prefix: -p
  - id: tsv_file
    type:
      - 'null'
      - string
    doc: Save results in tsv format in this file (None).
    inputBinding:
      position: 103
      prefix: -t
  - id: format
    type:
      - 'null'
      - string
    doc: Input format (BAM).
    inputBinding:
      position: 103
      prefix: -f
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet and do not print progress bar (False).
    inputBinding:
      position: 103
      prefix: -Q
outputs:
  - id: report
    type: File
    doc: Comparison report PDF.
    outputBinding:
      glob: $(inputs.report_pdf)
  - id: pickle
    type: File
    doc: Pickled comparison results.
    outputBinding:
      glob: $(inputs.results_pickle)
  - id: tsv
    type:
      - 'null'
      - File
    doc: Comparison results in tsv format.
    outputBinding:
      glob: $(inputs.tsv_file)
requirements:
  - class: EnvVarRequirement
    envDef:
      MPLBACKEND: Agg
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
