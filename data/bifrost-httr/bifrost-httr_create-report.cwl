cwlVersion: v1.2
class: CommandLineTool
baseCommand: bifrost-httr create-report
label: bifrost-httr_create-report
doc: "Create Bifrost HTTR reports using MultiQC.\n\nTool homepage: https://github.com/seqera-services/bifrost-httr"
inputs:
  - id: cds_threshold
    type:
      - 'null'
      - float
    doc: "Concentration-Dependency Score threshold for\n                         \
      \         filtering probes"
    inputBinding:
      position: 101
      prefix: --cds-threshold
  - id: cell_type
    type: string
    doc: Type of cell used in the test
    inputBinding:
      position: 101
      prefix: --cell-type
  - id: conc_units
    type:
      - 'null'
      - string
    doc: Concentration units
    inputBinding:
      position: 101
      prefix: --conc-units
  - id: custom_templates
    type:
      - 'null'
      - File
    doc: "Path to custom template YAML file to\n                                 \
      \ override default report templates"
    inputBinding:
      position: 101
      prefix: --custom-templates
  - id: interactive_plots
    type:
      - 'null'
      - boolean
    doc: "Force interactive plots (may be faster for\n                           \
      \       large datasets)"
    inputBinding:
      position: 101
      prefix: --interactive-plots
  - id: n_fold_change_probes
    type:
      - 'null'
      - int
    doc: "Number of most up/down regulated probes to\n                           \
      \       show"
    inputBinding:
      position: 101
      prefix: --n-fold-change-probes
  - id: n_lowest_means
    type:
      - 'null'
      - int
    doc: Number of lowest mean PoD probes to show
    inputBinding:
      position: 101
      prefix: --n-lowest-means
  - id: n_pod_stats
    type:
      - 'null'
      - int
    doc: "Number of probes to include in PoD\n                                  statistics
      table"
    inputBinding:
      position: 101
      prefix: --n-pod-stats
  - id: no_cds_threshold
    type:
      - 'null'
      - boolean
    doc: "Do not filter probes by CDS threshold in\n                             \
      \     summary tables and lowest mean PoDs section"
    inputBinding:
      position: 101
      prefix: --no-cds-threshold
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name for the output report
    inputBinding:
      position: 101
      prefix: --output-name
  - id: plot_height
    type:
      - 'null'
      - int
    doc: "Height of concentration-response plots in\n                            \
      \      pixels"
    inputBinding:
      position: 101
      prefix: --plot-height
  - id: pod_vs_fc_height
    type:
      - 'null'
      - int
    doc: Height of PoD vs Fold Change plot in pixels
    inputBinding:
      position: 101
      prefix: --pod-vs-fc-height
  - id: summary_file
    type: File
    doc: Path to the summary JSON file
    inputBinding:
      position: 101
      prefix: --summary-file
  - id: test_substance
    type: string
    doc: Name of the test substance
    inputBinding:
      position: 101
      prefix: --test-substance
  - id: timepoint
    type:
      - 'null'
      - string
    doc: Exposure duration within experiment
    inputBinding:
      position: 101
      prefix: --timepoint
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
stdout: bifrost-httr_create-report.out
