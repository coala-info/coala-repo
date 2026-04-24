cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellsnake
label: cellsnake_advanced
doc: "Main cellsnake executable\n\nTool homepage: https://github.com/sinanugur/cellsnake"
inputs:
  - id: command
    type: string
    doc: Command to run (e.g., minimal, standard, advanced, clustree, integrate)
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: Input directory or a file to process (if a directory given, batch mode 
      is ON). After integration, provide the Seurat object file not a directory 
      to work on integrated object, see tutorial if necessary (e.g. 
      analyses_integrated/seurat/integrated.rds)
    inputBinding:
      position: 2
  - id: celltypist_model
    type:
      - 'null'
      - string
    doc: refer to Celltypist for another model
    inputBinding:
      position: 103
      prefix: --celltypist_model
  - id: confidence
    type:
      - 'null'
      - double
    doc: see kraken2 manual
    inputBinding:
      position: 103
      prefix: --confidence
  - id: configfile
    type:
      - 'null'
      - string
    doc: Config file name in YAML format, for example, "config.yaml". No default
      but can be created with --generate-template.
    inputBinding:
      position: 103
      prefix: --configfile
  - id: dims
    type:
      - 'null'
      - int
    doc: refer to Seurat for more details
    inputBinding:
      position: 103
      prefix: --dims
  - id: doublet_filter
    type:
      - 'null'
      - boolean
    doc: this may fail on some samples and on low memory. If you have a problem,
      try False.
    inputBinding:
      position: 103
      prefix: --doublet_filter
  - id: dry
    type:
      - 'null'
      - boolean
    doc: Dry run, nothing will be generated.
    inputBinding:
      position: 103
      prefix: --dry
  - id: gene
    type:
      - 'null'
      - string
    doc: Create publication ready plots for a gene or a list of genes from a 
      text file.
    inputBinding:
      position: 103
      prefix: --gene
  - id: generate_template
    type:
      - 'null'
      - boolean
    doc: Generate config file template and metadata template in the current 
      directory.
    inputBinding:
      position: 103
      prefix: --generate-template
  - id: highly_variable_features
    type:
      - 'null'
      - int
    doc: seurat defaults, recommended
    inputBinding:
      position: 103
      prefix: --highly_variable_features
  - id: install_packages
    type:
      - 'null'
      - boolean
    doc: Install, reinstall or check required R packages.
    inputBinding:
      position: 103
      prefix: --install-packages
  - id: jobs
    type:
      - 'null'
      - int
    doc: Total CPUs.
    inputBinding:
      position: 103
      prefix: --jobs
  - id: kraken_db_folder
    type:
      - 'null'
      - string
    doc: No default, you need to provide a folder with kraken2 database
    inputBinding:
      position: 103
      prefix: --kraken_db_folder
  - id: logfc_threshold
    type:
      - 'null'
      - double
    inputBinding:
      position: 103
      prefix: --logfc_threshold
  - id: mapping
    type:
      - 'null'
      - string
    doc: you may install others from Bioconductor, this is for human
    inputBinding:
      position: 103
      prefix: --mapping
  - id: marker_plots_per_cluster_n
    type:
      - 'null'
      - int
    doc: plot summary marker plots for top markers
    inputBinding:
      position: 103
      prefix: --marker_plots_per_cluster_n
  - id: max_features
    type:
      - 'null'
      - int
    doc: seurat default, nFeature_RNA, 5000 can be a good cutoff
    inputBinding:
      position: 103
      prefix: --max_features
  - id: max_molecules
    type:
      - 'null'
      - int
    doc: seurat default, nCount_RNA, to filter potential doublets, doublet 
      filtering is already default, so keep this Inf
    inputBinding:
      position: 103
      prefix: --max_molecules
  - id: metadata
    type:
      - 'null'
      - string
    doc: Metadata file name in CSV, TSV or Excel format, for example, 
      "metadata.csv", header required, first column sample name. No default but 
      can be created with --generate-template.
    inputBinding:
      position: 103
      prefix: --metadata
  - id: metadata_column
    type:
      - 'null'
      - string
    doc: Metadata column for differential expression analysis
    inputBinding:
      position: 103
      prefix: --metadata_column
  - id: microbiome_min_cells
    type:
      - 'null'
      - int
    inputBinding:
      position: 103
      prefix: --microbiome_min_cells
  - id: microbiome_min_features
    type:
      - 'null'
      - int
    inputBinding:
      position: 103
      prefix: --microbiome_min_features
  - id: min_cells
    type:
      - 'null'
      - int
    doc: seurat default, recommended
    inputBinding:
      position: 103
      prefix: --min_cells
  - id: min_features
    type:
      - 'null'
      - int
    doc: seurat default, recommended, nFeature_RNA
    inputBinding:
      position: 103
      prefix: --min_features
  - id: min_hit_groups
    type:
      - 'null'
      - int
    doc: see kraken2 manual
    inputBinding:
      position: 103
      prefix: --min_hit_groups
  - id: min_molecules
    type:
      - 'null'
      - int
    doc: seurat default, nCount_RNA, min_features usually handles this so keep 
      it 0
    inputBinding:
      position: 103
      prefix: --min_molecules
  - id: min_percentage_to_plot
    type:
      - 'null'
      - double
    doc: only show clusters more than % of cells on the legend
    inputBinding:
      position: 103
      prefix: --min_percentage_to_plot
  - id: normalization_method
    type:
      - 'null'
      - string
    inputBinding:
      position: 103
      prefix: --normalization_method
  - id: organism
    type:
      - 'null'
      - string
    doc: alternatives https://www.genome.jp/kegg/catalog/org_list.html
    inputBinding:
      position: 103
      prefix: --organism
  - id: percent_mt
    type:
      - 'null'
      - double
    doc: Maximum mitochondrial gene percentage cutoff, for example, 5 or 10, 
      write "auto" for auto detection
    inputBinding:
      position: 103
      prefix: --percent_mt
  - id: percent_rp
    type:
      - 'null'
      - double
    doc: Ribosomal genes minimum percentage (0-100), default no filtering
    inputBinding:
      position: 103
      prefix: --percent_rp
  - id: reduction
    type:
      - 'null'
      - string
    doc: refer to Seurat for more details
    inputBinding:
      position: 103
      prefix: --reduction
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Delete all output files (this won't affect input files).
    inputBinding:
      position: 103
      prefix: --remove
  - id: resolution
    type:
      - 'null'
      - double
    doc: Resolution for cluster detection, write "auto" for auto detection
    inputBinding:
      position: 103
      prefix: --resolution
  - id: scale_factor
    type:
      - 'null'
      - int
    inputBinding:
      position: 103
      prefix: --scale_factor
  - id: show_labels
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --show_labels
  - id: singler_ref
    type:
      - 'null'
      - string
    doc: 
      https://bioconductor.org/packages/release/data/experiment/vignettes/celldex/inst/doc/userguide.html#1_Overview
    inputBinding:
      position: 103
      prefix: --singler_ref
  - id: species
    type:
      - 'null'
      - string
    doc: 'for cellchat, #only human or mouse is accepted'
    inputBinding:
      position: 103
      prefix: --species
  - id: taxa
    type:
      - 'null'
      - string
    doc: available options "domain", "kingdom", "phylum", "class", "order", 
      "family", "genus", "species"
    inputBinding:
      position: 103
      prefix: --taxa
  - id: test_use
    type:
      - 'null'
      - string
    inputBinding:
      position: 103
      prefix: --test_use
  - id: tsne_markers_plot
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --tsne_markers_plot
  - id: umap_markers_plot
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --umap_markers_plot
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Rescue stalled jobs (Try this if the previous job ended prematurely or 
      currently failing).
    inputBinding:
      position: 103
      prefix: --unlock
  - id: variable_selection_method
    type:
      - 'null'
      - string
    doc: seurat defaults, recommended
    inputBinding:
      position: 103
      prefix: --variable_selection_method
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
stdout: cellsnake_advanced.out
