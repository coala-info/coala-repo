cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyscenic_ctx
label: pyscenic_ctx
doc: "Enrich motifs in modules and generate regulons.\n\nTool homepage: https://github.com/aertslab/pySCENIC"
inputs:
  - id: module_fname
    type: File
    doc: 'The name of the file that contains the signature or the co-expression modules.
      The following formats are supported: CSV or TSV (adjacencies), YAML, GMT and
      DAT (modules)'
    inputBinding:
      position: 1
  - id: database_fname
    type:
      type: array
      items: File
    doc: 'The name(s) of the regulatory feature databases. Two file formats are supported:
      feather or db (legacy).'
    inputBinding:
      position: 2
  - id: all_modules
    type:
      - 'null'
      - boolean
    doc: 'Included positive and negative regulons in the analysis (default: no, i.e.
      only positive).'
    inputBinding:
      position: 103
      prefix: --all_modules
  - id: annotations_fname
    type: File
    doc: The name of the file that contains the motif annotations to use.
    inputBinding:
      position: 103
      prefix: --annotations_fname
  - id: auc_threshold
    type:
      - 'null'
      - float
    doc: The threshold used for calculating the AUC of a feature as fraction of 
      ranked genes
    inputBinding:
      position: 103
      prefix: --auc_threshold
  - id: cell_id_attribute
    type:
      - 'null'
      - string
    doc: The name of the column attribute that specifies the identifiers of the 
      cells in the loom file.
    inputBinding:
      position: 103
      prefix: --cell_id_attribute
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: The size of the module chunks assigned to a node in the dask graph
    inputBinding:
      position: 103
      prefix: --chunk_size
  - id: client_or_address
    type:
      - 'null'
      - string
    doc: The client or the IP address of the dask scheduler to use. (Only 
      required of dask_cluster is selected as mode)
    inputBinding:
      position: 103
      prefix: --client_or_address
  - id: expression_mtx_fname
    type:
      - 'null'
      - File
    doc: 'The name of the file that contains the expression matrix for the single
      cell experiment. Two file formats are supported: csv (rows=cells x columns=genes)
      or loom (rows=genes x columns=cells). (Only required if modules need to be generated)'
    inputBinding:
      position: 103
      prefix: --expression_mtx_fname
  - id: gene_attribute
    type:
      - 'null'
      - string
    doc: The name of the row attribute that specifies the gene symbols in the 
      loom file.
    inputBinding:
      position: 103
      prefix: --gene_attribute
  - id: mask_dropouts
    type:
      - 'null'
      - boolean
    doc: If modules need to be generated, this controls whether cell dropouts 
      (cells in which expression of either TF or target gene is 0) are masked 
      when calculating the correlation between a TF-target pair. This affects 
      which target genes are included in the initial modules, and the final 
      pruned regulon (by default only positive regulons are kept (see 
      --all_modules option)). The default value in pySCENIC 0.9.16 and previous 
      versions was to mask dropouts when calculating the correlation; however, 
      all cells are now kept by default, to match the R version.
    inputBinding:
      position: 103
      prefix: --mask_dropouts
  - id: max_similarity_fdr
    type:
      - 'null'
      - float
    doc: Maximum FDR in motif similarity to use when annotating enriched motifs
    inputBinding:
      position: 103
      prefix: --max_similarity_fdr
  - id: min_genes
    type:
      - 'null'
      - int
    doc: The minimum number of genes in a module
    inputBinding:
      position: 103
      prefix: --min_genes
  - id: min_orthologous_identity
    type:
      - 'null'
      - float
    doc: Minimum orthologous identity to use when annotating enriched motifs
    inputBinding:
      position: 103
      prefix: --min_orthologous_identity
  - id: mode
    type:
      - 'null'
      - string
    doc: The mode to be used for computing
    inputBinding:
      position: 103
      prefix: --mode
  - id: nes_threshold
    type:
      - 'null'
      - float
    doc: The Normalized Enrichment Score (NES) threshold for finding enriched 
      features
    inputBinding:
      position: 103
      prefix: --nes_threshold
  - id: no_pruning
    type:
      - 'null'
      - boolean
    doc: Do not perform pruning, i.e. find enriched motifs.
    inputBinding:
      position: 103
      prefix: --no_pruning
  - id: num_workers
    type:
      - 'null'
      - int
    doc: The number of workers to use. Only valid if using dask_multiprocessing,
      custom_multiprocessing or local as mode.
    inputBinding:
      position: 103
      prefix: --num_workers
  - id: rank_threshold
    type:
      - 'null'
      - int
    doc: The rank threshold used for deriving the target genes of an enriched 
      motif
    inputBinding:
      position: 103
      prefix: --rank_threshold
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: If set, load the expression data as a sparse matrix. Currently applies 
      to the grn inference step only.
    inputBinding:
      position: 103
      prefix: --sparse
  - id: thresholds
    type:
      - 'null'
      - type: array
        items: float
    doc: The first method to create the TF-modules based on the best targets for
      each transcription factor
      - 0.75
      - 0.9
    inputBinding:
      position: 103
      prefix: --thresholds
  - id: top_n_regulators
    type:
      - 'null'
      - type: array
        items: int
    doc: The alternative way to create the TF-modules is to select the best 
      regulators for each gene.
      - 5
      - 10
      - 50
    inputBinding:
      position: 103
      prefix: --top_n_regulators
  - id: top_n_targets
    type:
      - 'null'
      - type: array
        items: int
    doc: The second method is to select the top targets for a given TF.
      - 50
    inputBinding:
      position: 103
      prefix: --top_n_targets
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Transpose the expression matrix (rows=genes x columns=cells).
    inputBinding:
      position: 103
      prefix: --transpose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file/stream, i.e. a table of enriched motifs and target genes 
      (csv, tsv) or collection of regulons (yaml, gmt, dat, json).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyscenic:0.12.1--pyhdfd78af_1
