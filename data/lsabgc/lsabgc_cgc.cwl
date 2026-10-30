cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgc
label: lsabgc_cgc
doc: "Visualization of zol results along a consensus gene cluster sequence.\n\nTool homepage: https://github.com/Kalan-Lab/zol"
inputs:
  - id: zol_results_dir
    type: Directory
    doc: "Path to zol results directory."
    inputBinding:
      position: 1
      prefix: --zol-results-dir
  - id: outdir
    type: string
    doc: "Output directory for cgc analysis. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --outdir
  - id: tracks
    type:
      - 'null'
      - {type: array, items: string}
    doc: "Tracks to use, note the first track is used to color the gene schematic directly. Should be provided in desired order (bottom to top) [Default is 'conservation tajimas_d']."
    inputBinding:
      position: 1
      prefix: --tracks
  - id: color_schemes
    type:
      - 'null'
      - {type: array, items: string}
    doc: "Specify default color schemes avaibility by name in desired order matching --tracks [Default is 'white_to_black blue_white_red']."
    inputBinding:
      position: 1
      prefix: --color-schemes
  - id: custom_color_scheme_file
    type:
      - 'null'
      - File
    doc: "Tab-delimited file with 4 columns: (1) track_name, (2) low-value color hexcode, (3) mid-value color hexcode, (4) high-value color hexcode."
    inputBinding:
      position: 1
      prefix: --custom-color-scheme-file
  - id: annotation_db_faa
    type:
      - 'null'
      - File
    doc: "A FASTA file of proteins with headers to match to ortholog group consensus sequences. Will then use headers of matches (up until first space) as ortholog labels."
    inputBinding:
      position: 1
      prefix: --annotation-db-faa
  - id: og_label_file
    type:
      - 'null'
      - File
    doc: "Tab-delimited file with 2 columns: (1) ortholog group ID, (2) desired label."
    inputBinding:
      position: 1
      prefix: --og-label-file
  - id: min_conservation
    type:
      - 'null'
      - float
    doc: "Minimum proportion of gene clusters an ortholog group needs to be found in to be shown in the figure [Default is 0.1]."
    inputBinding:
      position: 1
      prefix: --min-conservation
  - id: relative_heights
    type:
      - 'null'
      - {type: array, items: string}
    doc: "Relative heights of individual tracks [Default is '1 1']."
    inputBinding:
      position: 1
      prefix: --relative-heights
  - id: show_labels
    type:
      - 'null'
      - boolean
    doc: "Show labels which by default are OG identifiers, if --og_label_file or --annotatIon_db_faa are not specified."
    inputBinding:
      position: 1
      prefix: --show-labels
  - id: label_distance
    type:
      - 'null'
      - float
    doc: "The distance between genes and labels [Default is 0.025]."
    inputBinding:
      position: 1
      prefix: --label-distance
  - id: label_text_size
    type:
      - 'null'
      - float
    doc: "Label text size [Default is 2.0]."
    inputBinding:
      position: 1
      prefix: --label-text-size
  - id: show_copy_count_status
    type:
      - 'null'
      - boolean
    doc: "Show whether genes are single-copy or not."
    inputBinding:
      position: 1
      prefix: --show-copy-count-status
  - id: squish_factor
    type:
      - 'null'
      - float
    doc: "A numeric value controlling vertical squishing of tracks in the plot - this value should be negative to squish or positive to give more space and proportional to the values provided for relative heights [Default is 0]."
    inputBinding:
      position: 1
      prefix: --squish-factor
  - id: bottom_spacing
    type:
      - 'null'
      - float
    doc: "Extra space for bottom of the plot to make sure legend does not get cut off. Should be proportional to values for relative heights [Default is 0.1]."
    inputBinding:
      position: 1
      prefix: --bottom-spacing
  - id: focal_set_title
    type:
      - 'null'
      - string
    doc: "Title to use for the focal set conservation track if requested. If spaces present, surround by quotes [Default is 'Focal Set Conservation']."
    inputBinding:
      position: 1
      prefix: --focal-set-title
  - id: comparator_set_title
    type:
      - 'null'
      - string
    doc: "Title to use for the alternate set conservation track if requested. If spaces present, surround by quotes [Default is 'Comparator Set Conservation']."
    inputBinding:
      position: 1
      prefix: --comparator-set-title
  - id: legend_title_size
    type:
      - 'null'
      - float
    doc: "Change legend title size [Default is 10]."
    inputBinding:
      position: 1
      prefix: --legend-title-size
  - id: no_legend
    type:
      - 'null'
      - boolean
    doc: "Do not show legend for coloring of the gene schematic."
    inputBinding:
      position: 1
      prefix: --no-legend
  - id: png
    type:
      - 'null'
      - boolean
    doc: "Create plot as PNG, default is PDF."
    inputBinding:
      position: 1
      prefix: --png
  - id: length
    type:
      - 'null'
      - float
    doc: "Specify the height/length of the heatmap plot in inches [Default is 7]."
    inputBinding:
      position: 1
      prefix: --length
  - id: width
    type:
      - 'null'
      - float
    doc: "Specify the width of the heatmap plot in inches [Default is 7]."
    inputBinding:
      position: 1
      prefix: --width
outputs:
  - id: outdir_dir
    type: Directory
    doc: Results directory written with --outdir.
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
