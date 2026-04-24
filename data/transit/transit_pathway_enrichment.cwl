cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - /usr/local/bin/transit
  - pathway_enrichment
label: transit_pathway_enrichment
doc: "Performs pathway enrichment analysis.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: resampling_file
    type: File
    doc: File containing resampling data.
    inputBinding:
      position: 1
  - id: associations
    type: File
    doc: File containing gene-association data.
    inputBinding:
      position: 2
  - id: pathways
    type: File
    doc: File containing pathway definitions.
    inputBinding:
      position: 3
  - id: enrichment_score_exponent
    type:
      - 'null'
      - float
    doc: Exponent to use in calculating enrichment score; recommend trying 0 or 
      1.
    inputBinding:
      position: 104
      prefix: -p
  - id: focus_lfc
    type:
      - 'null'
      - string
    doc: Filter the output to focus on results with positive (pos) or negative 
      (neg) LFCs.
    inputBinding:
      position: 104
  - id: lfc_column
    type:
      - 'null'
      - int
    doc: Column with log2FC (starting with 0; can also be negative, i.e. -1 
      means last col) (used for ranking genes by SLPV or LFC).
    inputBinding:
      position: 104
      prefix: -LFC_col
  - id: method
    type:
      - 'null'
      - string
    doc: "Method to use: FET for Fisher's Exact Test, GSEA for Gene Set Enrichment
      Analysis, or ONT for Ontologizer."
    inputBinding:
      position: 104
      prefix: -M
  - id: min_lfc
    type:
      - 'null'
      - float
    doc: Filter the output to include only genes that have a magnitude of LFC 
      greater than the specified value (e.g. '-minLFC 1' means analyze only 
      genes with 2-fold change or greater).
    inputBinding:
      position: 104
  - id: num_permutations
    type:
      - 'null'
      - int
    doc: Number of permutations to simulate for null distribution to determine 
      p-value.
    inputBinding:
      position: 104
      prefix: -Nperm
  - id: pseudo_counts
    type:
      - 'null'
      - int
    doc: Pseudo-counts to use in calculating p-value based on hypergeometric 
      distribution.
    inputBinding:
      position: 104
      prefix: -PC
  - id: pval_column
    type:
      - 'null'
      - int
    doc: Column with raw P-values (starting with 0; can also be negative, i.e. 
      -1 means last col) (used for sorting).
    inputBinding:
      position: 104
      prefix: -Pval_col
  - id: qval_column
    type:
      - 'null'
      - int
    doc: Column with adjusted P-values (starting with 0; can also be negative, 
      i.e. -1 means last col) (used for significant cutoff).
    inputBinding:
      position: 104
      prefix: -Qval_col
  - id: qval_cutoff
    type:
      - 'null'
      - float
    doc: Filter the output to include only genes that have Qval less than to the
      value specified.
    inputBinding:
      position: 104
  - id: ranking
    type:
      - 'null'
      - string
    doc: 'Ranking method for GSEA: SLPV (signed-log-p-value) or LFC (log2-fold-change
      from resampling).'
    inputBinding:
      position: 104
  - id: topk
    type:
      - 'null'
      - int
    doc: Calculate enrichment among top k genes ranked by significance (Qval) 
      regardless of cutoff (can combine with -focusLFC).
    inputBinding:
      position: 104
outputs:
  - id: output_file
    type: File
    doc: Output file for results.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
