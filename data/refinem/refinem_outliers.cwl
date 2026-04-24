cwlVersion: v1.2
class: CommandLineTool
baseCommand: refinem_outliers
label: refinem_outliers
doc: "Identify scaffolds with divergent genomic characteristics.\n\nTool homepage:
  http://pypi.python.org/pypi/refinem/"
inputs:
  - id: scaffold_stats_file
    type: File
    doc: file with statistics for each scaffold
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 2
  - id: cov_corr
    type:
      - 'null'
      - float
    doc: correlation for identifying scaffolds with divergent coverage profiles
    inputBinding:
      position: 103
      prefix: --cov_corr
  - id: cov_perc
    type:
      - 'null'
      - int
    doc: mean absolute percent error for identifying scaffolds with divergent 
      coverage profiles
    inputBinding:
      position: 103
      prefix: --cov_perc
  - id: create_plots
    type:
      - 'null'
      - boolean
    doc: create exploratory plots (currently unstable due to mpld3 limitations)
    inputBinding:
      position: 103
      prefix: --create_plots
  - id: dpi
    type:
      - 'null'
      - int
    doc: desired DPI of output image
    inputBinding:
      position: 103
      prefix: --dpi
  - id: gc_perc
    type:
      - 'null'
      - int
    doc: percentile for identify scaffolds with divergent GC content
    inputBinding:
      position: 103
      prefix: --gc_perc
  - id: height
    type:
      - 'null'
      - int
    doc: height of output image
    inputBinding:
      position: 103
      prefix: --height
  - id: highlight_file
    type:
      - 'null'
      - File
    doc: file indicating scaffolds to highlight
    inputBinding:
      position: 103
      prefix: --highlight_file
  - id: image_type
    type:
      - 'null'
      - string
    doc: desired image type
    inputBinding:
      position: 103
      prefix: --image_type
  - id: individual_plots
    type:
      - 'null'
      - boolean
    doc: create individual plots for each statistic
    inputBinding:
      position: 103
      prefix: --individual_plots
  - id: label_font_size
    type:
      - 'null'
      - int
    doc: desired font size for labels
    inputBinding:
      position: 103
      prefix: --label_font_size
  - id: links_file
    type:
      - 'null'
      - File
    doc: file indicating pairs of scaffolds to join by a line
    inputBinding:
      position: 103
      prefix: --links_file
  - id: point_size
    type:
      - 'null'
      - int
    doc: desired size of points in scatterplot
    inputBinding:
      position: 103
      prefix: --point_size
  - id: report_type
    type:
      - 'null'
      - string
    doc: report sequences that are outliers in 'all' or 'any' reference 
      distribution
    inputBinding:
      position: 103
      prefix: --report_type
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 103
      prefix: --silent
  - id: td_perc
    type:
      - 'null'
      - int
    doc: percentile for identify scaffolds with divergent tetranucleotide 
      signatures
    inputBinding:
      position: 103
      prefix: --td_perc
  - id: tick_font_size
    type:
      - 'null'
      - int
    doc: desired font size for tick markers
    inputBinding:
      position: 103
      prefix: --tick_font_size
  - id: width
    type:
      - 'null'
      - int
    doc: width of output image
    inputBinding:
      position: 103
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
stdout: refinem_outliers.out
