cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - pathway_enrichment
label: transit_pathway_enrichment
doc: "Pathway enrichment analysis (Fisher exact test, GSEA or Ontologizer) of a resampling result.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: resampling_file
    type: File
    doc: "Resampling (or other comparison) output file"
    inputBinding:
      position: 1
  - id: associations
    type: File
    doc: "Gene-to-pathway associations file"
    inputBinding:
      position: 2
  - id: pathways
    type: File
    doc: "Pathways (names) file"
    inputBinding:
      position: 3
  - id: output_filename
    type: string
    doc: "Output file name"
    inputBinding:
      position: 4
  - id: method
    type: ['null', string]
    doc: "Method to use: FET for Fisher's Exact Test (default), GSEA for Gene Set Enrichment Analysis, or ONT for Ontologizer"
    inputBinding:
      position: 20
      prefix: -M
  - id: pval_column
    type: ['null', int]
    doc: "Column with raw P-values (starting with 0; can also be negative, i.e. -1 means last col) (used for sorting). Default: -2"
    inputBinding:
      position: 20
      prefix: -Pval_col
  - id: qval_column
    type: ['null', int]
    doc: "Column with adjusted P-values (starting with 0; can also be negative) (used for significant cutoff). Default: -1"
    inputBinding:
      position: 20
      prefix: -Qval_col
  - id: ranking
    type: ['null', string]
    doc: "GSEA: SLPV is signed-log-p-value (default); LFC is log2-fold-change from resampling"
    inputBinding:
      position: 20
      prefix: -ranking
  - id: lfc_column
    type: ['null', int]
    doc: "GSEA: column with log2FC (starting with 0; can also be negative) (used for ranking genes by SLPV or LFC). Default: 6"
    inputBinding:
      position: 20
      prefix: -LFC_col
  - id: enrichment_score_exponent
    type: ['null', float]
    doc: "GSEA: exponent to use in calculating enrichment score; recommend trying 0 or 1"
    inputBinding:
      position: 20
      prefix: -p
  - id: num_permutations
    type: ['null', int]
    doc: "GSEA: number of permutations to simulate for null distribution to determine p-value. Default: 10000"
    inputBinding:
      position: 20
      prefix: -Nperm
  - id: focus_lfc
    type: ['null', string]
    doc: "FET: filter the output to focus on results with positive (pos) or negative (neg) LFCs. Default: all"
    inputBinding:
      position: 20
      prefix: -focusLFC
  - id: min_lfc
    type: ['null', float]
    doc: "FET: filter the output to include only genes that have a magnitude of LFC greater than the specified value. Default: 0"
    inputBinding:
      position: 20
      prefix: -minLFC
  - id: qval_cutoff
    type: ['null', float]
    doc: "FET: filter the output to include only genes that have Qval less than the value specified. Default: 0.05"
    inputBinding:
      position: 20
      prefix: -qval
  - id: topk
    type: ['null', int]
    doc: "FET: calculate enrichment among top k genes ranked by significance (Qval) regardless of cutoff (can combine with -focusLFC)"
    inputBinding:
      position: 20
      prefix: -topk
  - id: pseudo_counts
    type: ['null', int]
    doc: "FET: pseudo-counts to use in calculating p-value based on hypergeometric distribution. Default: 2"
    inputBinding:
      position: 20
      prefix: -PC
outputs:
  - id: output_file
    type: File
    doc: "Output file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
