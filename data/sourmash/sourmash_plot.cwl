cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot
label: sourmash_plot
doc: "Generate plots from sourmash compare output.\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: distances
    type: File
    doc: output from "sourmash compare"
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: forcibly plot non-distance matrices
    inputBinding:
      position: 102
      prefix: --force
  - id: labels_from
    type:
      - 'null'
      - File
    doc: a CSV file containing label information to use on plot; implies 
      --labels
    inputBinding:
      position: 102
      prefix: --labels-from
  - id: labels_load
    type:
      - 'null'
      - File
    doc: a CSV file containing label information to use on plot; implies 
      --labels
    inputBinding:
      position: 102
      prefix: --labels-load
  - id: labeltext
    type:
      - 'null'
      - string
    doc: filename containing list of labels (overrides signature names); implies
      --labels
    inputBinding:
      position: 102
      prefix: --labeltext
  - id: no_indices
    type:
      - 'null'
      - boolean
    doc: do not show sample indices
    inputBinding:
      position: 102
      prefix: --no-indices
  - id: no_labels
    type:
      - 'null'
      - boolean
    doc: do not show sample labels
    inputBinding:
      position: 102
      prefix: --no-labels
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: directory for output plots
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: output_pdf
    type:
      - 'null'
      - boolean
    doc: output PDF; default is PNG
    inputBinding:
      position: 102
      prefix: --pdf
  - id: show_indices
    type:
      - 'null'
      - boolean
    doc: show sample indices but not labels; overridden by --labels
    inputBinding:
      position: 102
      prefix: --indices
  - id: show_labels
    type:
      - 'null'
      - boolean
    doc: show sample labels on dendrogram/matrix
    inputBinding:
      position: 102
      prefix: --labels
  - id: subsample
    type:
      - 'null'
      - int
    doc: randomly downsample to this many samples, max
    inputBinding:
      position: 102
      prefix: --subsample
  - id: subsample_seed
    type:
      - 'null'
      - int
    doc: random seed for --subsample; default=1
    inputBinding:
      position: 102
      prefix: --subsample-seed
  - id: vmax
    type:
      - 'null'
      - float
    doc: upper limit of heatmap scale; default=1.000000
    inputBinding:
      position: 102
      prefix: --vmax
  - id: vmin
    type:
      - 'null'
      - float
    doc: lower limit of heatmap scale; default=0.000000
    inputBinding:
      position: 102
      prefix: --vmin
outputs:
  - id: csv_output
    type:
      - 'null'
      - File
    doc: write clustered matrix and labels out in CSV format (with column 
      headers) to this file
    outputBinding:
      glob: $(inputs.csv_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
