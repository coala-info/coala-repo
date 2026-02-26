cwlVersion: v1.2
class: CommandLineTool
baseCommand: enrichm
label: enrichm
doc: "Enrichment analysis of gene sets or pathways.\n\nTool homepage: https://github.com/geronimp/enrichM"
inputs:
  - id: input_genes
    type: File
    doc: Input file containing a list of genes (one gene per line).
    inputBinding:
      position: 1
  - id: gene_sets
    type: File
    doc: Input file containing gene sets (e.g., GO terms, pathways) in a 
      tab-separated format (gene_set_id\tgene1\tgene2\t...).
    inputBinding:
      position: 2
  - id: background_genes
    type:
      - 'null'
      - File
    doc: Optional file containing background genes for hypergeometric testing.
    inputBinding:
      position: 103
      prefix: --background-genes
  - id: enrichment_method
    type:
      - 'null'
      - string
    doc: Method for enrichment analysis (e.g., 'hypergeometric', 'fisher').
    default: hypergeometric
    inputBinding:
      position: 103
      prefix: --enrichment-method
  - id: max_genes_per_set
    type:
      - 'null'
      - int
    doc: Maximum number of genes allowed in a gene set to be considered.
    default: 500
    inputBinding:
      position: 103
      prefix: --max-genes-per-set
  - id: min_genes_per_set
    type:
      - 'null'
      - int
    doc: Minimum number of genes required in a gene set to be considered.
    default: 5
    inputBinding:
      position: 103
      prefix: --min-genes-per-set
  - id: network_algorithm
    type:
      - 'null'
      - string
    doc: Algorithm for constructing the gene set network (e.g., 'jaccard', 
      'overlap_coefficient').
    default: jaccard
    inputBinding:
      position: 103
      prefix: --network-algorithm
  - id: network_threshold
    type:
      - 'null'
      - float
    doc: Threshold for including edges in the gene set network.
    default: 0.5
    inputBinding:
      position: 103
      prefix: --network-threshold
  - id: p_value_threshold
    type:
      - 'null'
      - float
    doc: Significance threshold for p-values.
    default: 0.05
    inputBinding:
      position: 103
      prefix: --p-value-threshold
  - id: q_value_threshold
    type:
      - 'null'
      - float
    doc: Significance threshold for q-values (FDR).
    default: 0.1
    inputBinding:
      position: 103
      prefix: --q-value-threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_enrichment
    type:
      - 'null'
      - File
    doc: Output file for enrichment results.
    outputBinding:
      glob: $(inputs.output_enrichment)
  - id: output_network
    type:
      - 'null'
      - File
    doc: Output file for network visualization (e.g., GML format).
    outputBinding:
      glob: $(inputs.output_network)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enrichm:0.6.6--pyhdfd78af_0
