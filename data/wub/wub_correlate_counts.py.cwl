cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - correlate_counts.py
label: wub_correlate_counts.py
doc: 'Correlate counts produced by multiple runs of bam_count_reads.py.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_counts
    type: File[]
    doc: Input counts as tab separated files.
    inputBinding:
      position: 1
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: Report PDF (bam_multi_qc.pdf).
    default: bam_multi_qc.pdf
    inputBinding:
      position: 102
      prefix: -r
  - id: corr_type
    type:
      - 'null'
      - string
    doc: Correlation statistic - spearman or pearson (spearman).
    inputBinding:
      position: 102
      prefix: -c
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: Log transform data.
    inputBinding:
      position: 102
      prefix: -L
  - id: omit_lower_diagonal
    type:
      - 'null'
      - boolean
    doc: Omit lower diagonal.
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: report
    type: File
    doc: Count correlation report (PDF).
    outputBinding:
      glob: $(inputs.report_pdf)
requirements:
  - class: EnvVarRequirement
    envDef:
      MPLBACKEND: Agg
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
