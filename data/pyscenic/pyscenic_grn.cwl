cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyscenic
  - grn
label: pyscenic_grn
doc: "Infer gene regulatory networks\n\nTool homepage: https://github.com/aertslab/pySCENIC"
inputs:
  - id: expression_mtx_fname
    type: File
    doc: 'The name of the file that contains the expression matrix for the single
      cell experiment. Two file formats are supported: csv (rows=cells x columns=genes)
      or loom (rows=genes x columns=cells).'
    inputBinding:
      position: 1
  - id: tfs_fname
    type: File
    doc: The name of the file that contains the list of transcription factors 
      (TXT; one TF per line).
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
  - id: client_or_address
    type:
      - 'null'
      - string
    doc: The client or the IP address of the dask scheduler to use. (Only 
      required of dask_cluster is selected as mode)
    inputBinding:
      position: 103
      prefix: --client_or_address
  - id: gene_attribute
    type:
      - 'null'
      - string
    doc: The name of the row attribute that specifies the gene symbols in the 
      loom file.
    inputBinding:
      position: 103
      prefix: --gene_attribute
  - id: method
    type:
      - 'null'
      - string
    doc: 'The algorithm for gene regulatory network reconstruction (default: grnboost2).'
    inputBinding:
      position: 103
      prefix: --method
  - id: num_workers
    type:
      - 'null'
      - int
    doc: 'The number of workers to use. Only valid if using dask_multiprocessing,
      custom_multiprocessing or local as mode. (default: 20).'
    inputBinding:
      position: 103
      prefix: --num_workers
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed value for regressor random state initialization. Applies to both 
      GENIE3 and GRNBoost2. The default is to use a random seed.
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
    doc: Transpose the expression matrix (rows=genes x columns=cells).
    inputBinding:
      position: 103
      prefix: --transpose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file/stream, i.e. a table of TF-target genes (CSV).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyscenic:0.12.1--pyhdfd78af_1
