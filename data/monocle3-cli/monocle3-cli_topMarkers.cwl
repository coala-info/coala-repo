cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monocle3
  - topMarkers
label: monocle3-cli_topMarkers
doc: "Get top markers for each groups\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
inputs:
  - id: input_object
    type: File
    doc: "Input object, CellDataSet V3 (cds3) as an RDS file. Only cds3 is supported currently."
    inputBinding:
      position: 1
  - id: output_table
    type: string
    doc: "Output table file name."
    inputBinding:
      position: 2
  - id: input_object_format
    type:
      - 'null'
      - string
    doc: "Format of input object. [Default: cds3]"
    inputBinding:
      position: 103
      prefix: -f
  - id: output_table_format
    type:
      - 'null'
      - string
    doc: "Format of output table, choose from {tsv, csv}. [Default: tsv]"
    inputBinding:
      position: 103
      prefix: -F
  - id: introspective
    type:
      - 'null'
      - boolean
    doc: "Print introspective information of the output table."
    inputBinding:
      position: 103
      prefix: -I
  - id: group_cells_by
    type:
      - 'null'
      - string
    doc: "Cell groups, choose from \"cluster\", \"partition\", or any categorical variable in `colData(cds)`. [Default: cluster]"
    inputBinding:
      position: 103
      prefix: --group-cells-by
  - id: genes_to_test_per_group
    type:
      - 'null'
      - int
    doc: "Numeric, how many genes of the top ranked specific genes by Jenson-Shannon to do the more expensive regression test on. [Default: 25]"
    inputBinding:
      position: 103
      prefix: --genes-to-test-per-group
  - id: marker_sig_test
    type:
      - 'null'
      - boolean
    doc: "A flag indicating whether to assess the discriminative power of each marker through logistic regression. Can be slow, consider disabling to speed up top_markers(). [Default: FALSE]"
    inputBinding:
      position: 103
      prefix: --marker-sig-test
  - id: reference_cells
    type:
      - 'null'
      - string
    doc: "If provided, top_markers will perform the marker significance test against a \"reference set\" of cells. Must be either a list of cell ids from colnames(cds) (comma separated), or a positive integer. If the latter, top_markers() will randomly select the specified number of reference cells. Accelerates the marker significance test at some cost in sensitivity."
    inputBinding:
      position: 103
      prefix: --reference-cells
  - id: cores
    type:
      - 'null'
      - int
    doc: "The number of cores to be used for marker testing. [Default: 1]"
    inputBinding:
      position: 103
      prefix: --cores
  - id: filter_fraction_expression
    type:
      - 'null'
      - float
    doc: "Filters the markers test result by this fraction of expression [Default: 0.1]"
    inputBinding:
      position: 103
      prefix: --filter-fraction-expression
  - id: top_n_markers
    type:
      - 'null'
      - int
    doc: "The number of top marker genes to report in plots and in top markers list. [Default: 5]"
    inputBinding:
      position: 103
      prefix: --top-n-markers
  - id: plot_top_markers
    type:
      - 'null'
      - string
    doc: "Save top marker by cell group plot to a file specified by this option."
    inputBinding:
      position: 103
      prefix: --plot-top-markers
  - id: save_full_markers
    type:
      - 'null'
      - string
    doc: "Save full marker table to a file specified by this option."
    inputBinding:
      position: 103
      prefix: --save-full-markers
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Emit verbose output."
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_table
    type: File
    doc: "Output table"
    outputBinding:
      glob: $(inputs.output_table)
  - id: plot_top_markers
    type:
      - 'null'
      - File
    doc: "Top marker plot, when --plot-top-markers is set"
    outputBinding:
      glob: $(inputs.plot_top_markers)
  - id: save_full_markers
    type:
      - 'null'
      - File
    doc: "Full marker table, when --save-full-markers is set"
    outputBinding:
      glob: $(inputs.save_full_markers)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
