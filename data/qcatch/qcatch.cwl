cwlVersion: v1.2
class: CommandLineTool
baseCommand: qcatch
label: qcatch
doc: "QCatch: Command-line Interface\n\nTool homepage: https://github.com/COMBINE-lab/QCatch"
inputs:
  - id: chemistry
    type:
      - 'null'
      - string
    doc: "Specifies the chemistry used in the experiment, which\ndetermines the range
      for the empty_drops step.\nSupported options: '10X_3p_v2', '10X_3p_v3',\n'10X_3p_v4',
      '10X_5p_v3', '10X_3p_LT', '10X_HT'. If\nyou used a standard 10X chemistry (e.g.,
      '10X_3p_v2',\n'10X_3p_v3') and performed quantification with\n`simpleaf`(v0.19.5
      or later), QCatch can usually infer\nthe correct chemistry automatically from
      the metadata.\nIf inference fails, QCatch will stop and prompt you to\nprovide
      the chemistry explicitly via this flag."
    inputBinding:
      position: 101
      prefix: --chemistry
  - id: export_summary_table
    type:
      - 'null'
      - boolean
    doc: "If enabled, QCatch will export the summary metrics as\na separate CSV file."
    inputBinding:
      position: 101
      prefix: --export_summary_table
  - id: gene_id2name_file
    type:
      - 'null'
      - File
    doc: "File provides a mapping from gene IDs to gene names.\nThe file must be a
      TSV containing two\ncolumns—‘gene_id’ (e.g., ENSG00000284733) and\n‘gene_name’
      (e.g., OR4F29)—without a header row. If\nnot provided, the program will attempt
      to retrieve the\nmapping from a remote registry. If that lookup fails,\nmitochondria
      plots will not be displayed."
    inputBinding:
      position: 101
      prefix: --gene_id2name_file
  - id: input
    type: File
    doc: "Path to either the .h5ad file itself or to the\ndirectory containing the
      quantification output files."
    inputBinding:
      position: 101
      prefix: --input
  - id: n_partitions
    type:
      - 'null'
      - int
    doc: "Number of partitions (max number of barcodes to\nconsider for ambient estimation).
      Use `--n_partitions`\nonly when working with a custom or unsupported\nchemistry.
      When provided, this value will override the\nchemistry-based configuration during
      the cell-calling\nstep."
    inputBinding:
      position: 101
      prefix: --n_partitions
  - id: remove_doublets
    type:
      - 'null'
      - boolean
    doc: "If enabled, QCatch will perform doublet detection(use\n`Scrublet` tool)
      and remove detected doublets from the\ncells retained after cell calling."
    inputBinding:
      position: 101
      prefix: --remove_doublets
  - id: save_filtered_h5ad
    type:
      - 'null'
      - boolean
    doc: "If enabled, QCatch will save a separate `.h5ad` file\ncontaining only the
      retained cells."
    inputBinding:
      position: 101
      prefix: --save_filtered_h5ad
  - id: skip_umap_tsne
    type:
      - 'null'
      - boolean
    doc: If provided, skips generation of UMAP and t-SNE plots.
    inputBinding:
      position: 101
      prefix: --skip_umap_tsne
  - id: valid_cell_list
    type:
      - 'null'
      - File
    doc: "File provides a user-specified list of valid cell\nbarcode. The file must
      be a TSV containing one column\nwith cell barcodes without a header row. If
      provided,\nqcatch will skip the internal cell calling steps and\nand use the
      supplied list instead."
    inputBinding:
      position: 101
      prefix: --valid_cell_list
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging with debug-level messages
    inputBinding:
      position: 101
      prefix: --verbose
  - id: visualize_doublets
    type:
      - 'null'
      - boolean
    doc: "If set, generates additional UMAP and t-SNE plots that\ninclude doublets
      (alongside the standard doublet-free\nplots)."
    inputBinding:
      position: 101
      prefix: --visualize_doublets
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: "Path to the desired output directory (optional) . If\nprovided, QCatch will
      save all result files and the QC\nreport to this directory without modifying
      the\noriginal input. If not provided, QCatch will overwrite\nthe original `.h5ad`
      file in place by appending new\ncolumns on anndata.obs(if input is a `.h5ad`),
      or save\nresults in the input directory (if input is a folder\nof quantification
      results)."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qcatch:0.2.10--pyhdfd78af_0
