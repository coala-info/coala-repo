cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_gc_vs_qual.py
label: wub_bam_gc_vs_qual.py
doc: 'Produce a plot of GC content of aligned read and reference portion versus their
  mean quality values.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: bam
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: Reference fasta.
    inputBinding:
      position: 102
      prefix: -f
  - id: aqual
    type:
      - 'null'
      - int
    doc: Minimum alignment quality (0).
    inputBinding:
      position: 102
      prefix: -q
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: Report PDF (bam_gc_vs_qual.pdf).
    default: bam_gc_vs_qual.pdf
    inputBinding:
      position: 102
      prefix: -r
  - id: tsv
    type:
      - 'null'
      - string
    doc: Tab separated file to save results (bam_gc_vs_qual.tsv).
    default: bam_gc_vs_qual.tsv
    inputBinding:
      position: 102
      prefix: -t
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet and do not show progress bars.
    inputBinding:
      position: 102
      prefix: -Q
outputs:
  - id: report
    type: File
    doc: Plot of GC content versus mean quality (PDF).
    outputBinding:
      glob: $(inputs.report_pdf)
  - id: results_tsv
    type: File
    doc: Tab separated GC content and quality values.
    outputBinding:
      glob: $(inputs.tsv)
requirements:
  - class: EnvVarRequirement
    envDef:
      MPLBACKEND: Agg
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
