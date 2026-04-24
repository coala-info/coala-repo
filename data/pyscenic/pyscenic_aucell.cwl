cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyscenic_aucell
label: pyscenic_aucell
doc: "Calculate AUC for each cell and each gene signature.\n\nTool homepage: https://github.com/aertslab/pySCENIC"
inputs:
  - id: expression_mtx_fname
    type: File
    doc: 'The name of the file that contains the expression matrix for the single
      cell experiment. Two file formats are supported: csv (rows=cells x columns=genes)
      or loom (rows=genes x columns=cells).'
    inputBinding:
      position: 1
  - id: signatures_fname
    type: File
    doc: 'The name of the file that contains the gene signatures. Three file formats
      are supported: gmt, yaml or dat (pickle).'
    inputBinding:
      position: 2
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
  - id: gene_attribute
    type:
      - 'null'
      - string
    doc: The name of the row attribute that specifies the gene symbols in the 
      loom file.
    inputBinding:
      position: 103
      prefix: --gene_attribute
  - id: nes_threshold
    type:
      - 'null'
      - float
    doc: The Normalized Enrichment Score (NES) threshold for finding enriched 
      features
    inputBinding:
      position: 103
      prefix: --nes_threshold
  - id: num_workers
    type:
      - 'null'
      - int
    doc: The number of workers to use
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
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the expression matrix ranking step. The default is to use a 
      random seed.
    inputBinding:
      position: 103
      prefix: --seed
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: If set, load the expression data as a sparse matrix. Currently applies 
      to the grn inference step only.
    inputBinding:
      position: 103
      prefix: --sparse
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Transpose the expression matrix if supplied as csv (rows=genes x 
      columns=cells).
    inputBinding:
      position: 103
      prefix: --transpose
  - id: weights
    type:
      - 'null'
      - boolean
    doc: Use weights associated with genes in recovery analysis. Is only 
      relevant when gene signatures are supplied as json format.
    inputBinding:
      position: 103
      prefix: --weights
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output file/stream, a matrix of AUC values. Two file formats are supported:
      csv or loom. If loom file is specified the loom file while contain the original
      expression matrix and the calculated AUC values as extra column attributes.'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyscenic:0.12.1--pyhdfd78af_1
