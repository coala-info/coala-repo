cwlVersion: v1.2
class: CommandLineTool
baseCommand: ConSplice constraint
label: consplice_constraint
doc: "Module to generate genic or regional\nsplicing constraint using patterns of\n\
  purifying selection and evidence of\nalternative splicing\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: agg_overlapping_reg
    type: string
    doc: "Aggregate scores from overlapping regions where the\nstep size of a region
      is less than the window size of\nthe region"
    inputBinding:
      position: 1
  - id: calculate_oe
    type: string
    doc: Calculate the O/E and Percentile constraint scores
    inputBinding:
      position: 2
  - id: oe_counts
    type: string
    doc: "Calculate Observed and Expected splicing variant\ncounts for genic or intragenic
      regions of genes"
    inputBinding:
      position: 3
  - id: score_bed
    type: string
    doc: Add ConSplice scores to a bed variant file
    inputBinding:
      position: 4
  - id: score_txt
    type: string
    doc: "Add ConSplice scores to a tab-delimited txt variant\nfile"
    inputBinding:
      position: 5
  - id: score_vcf
    type: string
    doc: Add ConSplice scores to a vcf file
    inputBinding:
      position: 6
  - id: select_score
    type: string
    doc: "Select an O/E and matching Percentile score to filter\non and remove all
      other non-essential columns after\nConSplice scoring"
    inputBinding:
      position: 7
  - id: sub_matrix
    type: string
    doc: "Build a substitution matrix using gnomAD variants and\nSpliceAI scores"
    inputBinding:
      position: 8
  - id: subcommand
    type: string
    doc: 'Subcommand to run. Available options: sub-matrix, oe-counts, calculate-oe,
      select-score, agg-overlapping-reg, to-bed, score-txt, score-bed, score-vcf'
    inputBinding:
      position: 9
  - id: to_bed
    type: string
    doc: "Convert the 1-based scored ConSplice txt file to a\n0-based bed file"
    inputBinding:
      position: 10
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
stdout: consplice_constraint.out
