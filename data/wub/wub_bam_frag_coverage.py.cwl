cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_frag_coverage.py
label: wub_bam_frag_coverage.py
doc: "Produce aggregated and individual plots of fragment coverage.\n\nTool homepage:
  https://github.com/nanoporetech/wub"
inputs:
  - id: bam
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 1
  - id: bam_tag
    type:
      - 'null'
      - string
    doc: Dataset tag (BAM basename).
    inputBinding:
      position: 102
      prefix: -t
  - id: bins
    type:
      - 'null'
      - string
    doc: Number of bins
    inputBinding:
      position: 102
      prefix: -b
  - id: cov80_tsv
    type:
      - 'null'
      - File
    doc: Tab separated file with per-chromosome cov80 scores. Requires the -x 
      option to be specified.
    inputBinding:
      position: 102
      prefix: -l
  - id: glob_cov80_tsv
    type:
      - 'null'
      - File
    doc: Tab separated file with global cov80 score
    inputBinding:
      position: 102
      prefix: -g
  - id: intervals
    type:
      - 'null'
      - string
    doc: Length intervals
    inputBinding:
      position: 102
      prefix: -i
  - id: min_alignment_quality
    type:
      - 'null'
      - int
    doc: Minimum alignment quality
    inputBinding:
      position: 102
      prefix: -q
  - id: no_log_coverage
    type:
      - 'null'
      - boolean
    doc: Do not take log of coverage.
    inputBinding:
      position: 102
      prefix: -o
  - id: plot_per_reference
    type:
      - 'null'
      - boolean
    doc: Plot per-reference information.
    inputBinding:
      position: 102
      prefix: -x
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
    inputBinding:
      position: 102
      prefix: -c
  - id: report_pdf
    type:
      - 'null'
      - File
    doc: Report PDF
    inputBinding:
      position: 102
      prefix: -r
  - id: results_pickle
    type:
      - 'null'
      - File
    doc: Save pickled results in this file
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
stdout: wub_bam_frag_coverage.py.out
