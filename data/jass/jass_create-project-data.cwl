cwlVersion: v1.2
class: CommandLineTool
baseCommand: jass create-project-data
label: jass_create-project-data
doc: "Create project data for JASS\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
inputs:
  - id: phenotypes
    type:
      type: array
      items: string
    doc: list of selected phenotypes
    inputBinding:
      position: 1
  - id: worktable_path
    type: File
    doc: path to the worktable file to generate
    inputBinding:
      position: 2
  - id: chromosome_number
    type:
      - 'null'
      - int
    doc: 'option used only for local analysis: chromosome number studied'
    inputBinding:
      position: 103
      prefix: --chromosome-number
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of region to load in memory at once
    inputBinding:
      position: 103
      prefix: --chunk-size
  - id: custom_loadings
    type:
      - 'null'
      - File
    doc: path toward a csv file containing custom loading for sumZ tests
    inputBinding:
      position: 103
      prefix: --custom-loadings
  - id: end_position
    type:
      - 'null'
      - int
    doc: 'option used only for local analysis: end position of the region studied'
    inputBinding:
      position: 103
      prefix: --end-position
  - id: fisher_test
    type:
      - 'null'
      - boolean
    doc: Use Fisher's exact test
    inputBinding:
      position: 103
      prefix: --fisher_test
  - id: init_table_path
    type:
      - 'null'
      - File
    doc: path to the initial data file, default is the configured path 
      (JASS_DATA_DIR/initTable.hdf5)
    inputBinding:
      position: 103
      prefix: --init-table-path
  - id: meta_analysis
    type:
      - 'null'
      - boolean
    doc: Perform meta-analysis
    inputBinding:
      position: 103
      prefix: --meta_analysis
  - id: omnibus
    type:
      - 'null'
      - boolean
    doc: Use omnibus test
    inputBinding:
      position: 103
      prefix: --omnibus
  - id: post_filtering
    type:
      - 'null'
      - boolean
    doc: If a filtering to remove outlier will be applied (in this case the 
      result of SNPs considered aberant will not appear in the worktable)
    inputBinding:
      position: 103
      prefix: --post-filtering
  - id: remove_nans
    type:
      - 'null'
      - boolean
    doc: Remove NaNs from the data
    inputBinding:
      position: 103
      prefix: --remove-nans
  - id: significance_treshold
    type:
      - 'null'
      - float
    doc: The treshold at which a p-value is considered significant
    inputBinding:
      position: 103
      prefix: --significance-treshold
  - id: start_position
    type:
      - 'null'
      - int
    doc: 'option used only for local analysis: start position of the region studied'
    inputBinding:
      position: 103
      prefix: --start-position
  - id: strategy
    type:
      - 'null'
      - string
    doc: Specify analysis strategy
    inputBinding:
      position: 103
      prefix: --strategy
  - id: sumz
    type:
      - 'null'
      - boolean
    doc: Use sumz test
    inputBinding:
      position: 103
      prefix: --sumz
outputs:
  - id: manhattan_plot_path
    type:
      - 'null'
      - File
    doc: path to the genome-wide manhattan plot to generate
    outputBinding:
      glob: $(inputs.manhattan_plot_path)
  - id: quadrant_plot_path
    type:
      - 'null'
      - File
    doc: path to the quadrant plot to generate
    outputBinding:
      glob: $(inputs.quadrant_plot_path)
  - id: zoom_plot_path
    type:
      - 'null'
      - File
    doc: path to the local plot to generate
    outputBinding:
      glob: $(inputs.zoom_plot_path)
  - id: qq_plot_path
    type:
      - 'null'
      - File
    doc: path to the quantile-quantile plot to generate
    outputBinding:
      glob: $(inputs.qq_plot_path)
  - id: csv_file_path
    type:
      - 'null'
      - File
    doc: path to the results file in csv format
    outputBinding:
      glob: $(inputs.csv_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
