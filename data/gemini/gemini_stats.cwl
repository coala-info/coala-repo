cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini_stats
label: gemini_stats
doc: "Report statistics about variants in a GEMINI database.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: gt_filter
    type:
      - 'null'
      - string
    doc: Restrictions to apply to genotype values
    inputBinding:
      position: 102
      prefix: --gt-filter
  - id: gts_by_sample
    type:
      - 'null'
      - boolean
    doc: Report the count of each genotype class obs. per sample.
    inputBinding:
      position: 102
      prefix: --gts-by-sample
  - id: mds
    type:
      - 'null'
      - boolean
    doc: Report the pairwise genetic distance between the samples.
    inputBinding:
      position: 102
      prefix: --mds
  - id: sfs
    type:
      - 'null'
      - boolean
    doc: Report the site frequency spectrum of the variants.
    inputBinding:
      position: 102
      prefix: --sfs
  - id: snp_counts
    type:
      - 'null'
      - boolean
    doc: Report the count of each type of SNP (A->G, G->T, etc.).
    inputBinding:
      position: 102
      prefix: --snp-counts
  - id: summarize
    type:
      - 'null'
      - string
    doc: The query to be issued to the database to summarize
    inputBinding:
      position: 102
      prefix: --summarize
  - id: tstv
    type:
      - 'null'
      - boolean
    doc: Report the overall ts/tv ratio.
    inputBinding:
      position: 102
      prefix: --tstv
  - id: tstv_coding
    type:
      - 'null'
      - boolean
    doc: Report the ts/tv ratio in coding regions.
    inputBinding:
      position: 102
      prefix: --tstv-coding
  - id: tstv_noncoding
    type:
      - 'null'
      - boolean
    doc: Report the ts/tv ratio in non-coding regions.
    inputBinding:
      position: 102
      prefix: --tstv-noncoding
  - id: vars_by_sample
    type:
      - 'null'
      - boolean
    doc: Report the number of variants observed in each sample.
    inputBinding:
      position: 102
      prefix: --vars-by-sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_stats.out
