cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyscenic add_cor
label: pyscenic_add_cor
doc: "Add correlation information to GRN adjacencies.\n\nTool homepage: https://github.com/aertslab/pySCENIC"
inputs:
  - id: adjacencies
    type: File
    doc: The name of the file that contains the GRN adjacencies (output from the
      GRN step).
    inputBinding:
      position: 1
  - id: expression_mtx_fname
    type: File
    doc: 'The name of the file that contains the expression matrix for the single
      cell experiment. Two file formats are supported: csv (rows=cells x columns=genes)
      or loom (rows=genes x columns=cells).'
    inputBinding:
      position: 2
  - id: cell_id_attribute
    type:
      - 'null'
      - string
    doc: The name of the column attribute that specifies the identifiers of the 
      cells in the loom file.
    inputBinding:
      position: 103
      prefix: --cell_id_attribute
  - id: expression_mtx_fname_for_modules
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
  - id: min_genes
    type:
      - 'null'
      - int
    doc: 'The minimum number of genes in a module (default: 20).'
    inputBinding:
      position: 103
      prefix: --min_genes
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
    doc: 'The first method to create the TF-modules based on the best targets for
      each transcription factor (default: 0.75 0.90).'
    inputBinding:
      position: 103
      prefix: --thresholds
  - id: top_n_regulators
    type:
      - 'null'
      - type: array
        items: int
    doc: 'The alternative way to create the TF-modules is to select the best regulators
      for each gene. (default: 5 10 50)'
    inputBinding:
      position: 103
      prefix: --top_n_regulators
  - id: top_n_targets
    type:
      - 'null'
      - type: array
        items: int
    doc: 'The second method is to select the top targets for a given TF. (default:
      50)'
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
    doc: Output file/stream, i.e. the adjacencies table with correlations (csv, 
      tsv).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyscenic:0.12.1--pyhdfd78af_1
