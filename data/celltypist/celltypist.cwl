cwlVersion: v1.2
class: CommandLineTool
baseCommand: celltypist
label: celltypist
doc: "Celltypist: a tool for semi-automatic cell type annotation\n\nTool homepage:
  https://github.com/Teichlab/celltypist"
inputs:
  - id: cell_file
    type:
      - 'null'
      - File
    doc: Path to the file which stores each cell per line corresponding to the 
      cells used in the provided mtx file. Ignored if `-i / --indata` is not 
      provided in the mtx format.
    inputBinding:
      position: 101
      prefix: --cell-file
  - id: gene_file
    type:
      - 'null'
      - File
    doc: Path to the file which stores each gene per line corresponding to the 
      genes used in the provided mtx file. Ignored if `-i / --indata` is not 
      provided in the mtx format.
    inputBinding:
      position: 101
      prefix: --gene-file
  - id: indata
    type: File
    doc: Path to the input count matrix (.csv/txt/tsv/tab/mtx) or AnnData 
      (.h5ad). Genes should be provided as gene symbols.
    inputBinding:
      position: 101
      prefix: --indata
  - id: majority_voting
    type:
      - 'null'
      - boolean
    doc: Refine the predicted labels by running the majority voting classifier 
      after over-clustering.
    inputBinding:
      position: 101
      prefix: --majority-voting
  - id: min_prop
    type:
      - 'null'
      - float
    doc: For the dominant cell type within a subcluster, the minimum proportion 
      of cells required to support naming of the subcluster by this cell type. 
      Ignored if `--majority-voting` is not set.
    inputBinding:
      position: 101
      prefix: --min-prop
  - id: mode
    type:
      - 'null'
      - string
    doc: Choose the cell type with the largest score/probability as the final 
      prediction (`best_match`), or enable a multi-label classification 
      (`prob_match`), which assigns 0 (i.e., unassigned), 1, or >=2 cell type 
      labels to each query cell.
    inputBinding:
      position: 101
      prefix: --mode
  - id: model
    type:
      - 'null'
      - string
    doc: Model used for predictions. If not provided, default to using the 
      `Immune_All_Low.pkl` model.
    inputBinding:
      position: 101
      prefix: --model
  - id: over_clustering
    type:
      - 'null'
      - string
    doc: Input file with the over-clustering result of one cell per line, or a 
      string key specifying an existing metadata column in the AnnData object. 
      If not provided, default to using a heuristic over-clustering approach 
      according to the size of input data. Ignored if `--majority-voting` is not
      set.
    inputBinding:
      position: 101
      prefix: --over-clustering
  - id: p_thres
    type:
      - 'null'
      - float
    doc: Probability threshold for the multi-label classification. Ignored if 
      `--mode` is `best_match`.
    inputBinding:
      position: 101
      prefix: --p-thres
  - id: plot_results
    type:
      - 'null'
      - boolean
    doc: Plot the prediction results as multiple figures as well.
    inputBinding:
      position: 101
      prefix: --plot-results
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output files and (if `--plot-results` is set) figures. 
      Default to no prefix used.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Hide the banner and configuration information during the run.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: show_models
    type:
      - 'null'
      - boolean
    doc: Show all the available models and their descriptions.
    inputBinding:
      position: 101
      prefix: --show-models
  - id: transpose_input
    type:
      - 'null'
      - boolean
    doc: Transpose the input matrix if `-i / --indata` file is provided in the 
      gene-by-cell format. Note Celltypist requires the cell-by-gene format.
    inputBinding:
      position: 101
      prefix: --transpose-input
  - id: update_models
    type:
      - 'null'
      - boolean
    doc: Download the latest models from the remote server.
    inputBinding:
      position: 101
      prefix: --update-models
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: Whether to use GPU for over clustering on the basis of 
      `rapids-singlecell`. Ignored if `--majority-voting` is not set.
    inputBinding:
      position: 101
      prefix: --use-GPU
  - id: xlsx
    type:
      - 'null'
      - boolean
    doc: Merge output tables into a single Excel (.xlsx).
    inputBinding:
      position: 101
      prefix: --xlsx
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to store the output files and (if `--plot-results` is set) 
      figures. Default to the current working directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/celltypist:1.7.1--pyhdfd78af_0
