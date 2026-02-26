cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtools
  - covplot
label: blobtools_covplot
doc: "Create coverage plots from BlobDB and coverage files.\n\nTool homepage: https://blobtools.readme.io/docs/what-is-blobtools"
inputs:
  - id: blobdb_file
    type: File
    doc: BlobDB file
    inputBinding:
      position: 101
      prefix: --infile
  - id: catcolour_file
    type:
      - 'null'
      - File
    doc: 'Colour plot based on categories from FILE (format : "seq,category").'
    inputBinding:
      position: 101
      prefix: --catcolour
  - id: color_by_c_index
    type:
      - 'null'
      - boolean
    doc: Colour blobs by 'c index'
    default: false
    inputBinding:
      position: 101
      prefix: --cindex
  - id: color_file
    type:
      - 'null'
      - File
    doc: File containing colours for (taxonomic) groups
    inputBinding:
      position: 101
      prefix: --colours
  - id: cov_file
    type: File
    doc: COV file to be used in y-axis
    inputBinding:
      position: 101
      prefix: --cov
  - id: covlib
    type:
      - 'null'
      - string
    doc: Plot only certain covlib(s). Separated by ","
    inputBinding:
      position: 101
      prefix: --lib
  - id: cumulative_plot
    type:
      - 'null'
      - boolean
    doc: Print plot after addition of each (taxonomic) group
    inputBinding:
      position: 101
      prefix: --cumulative
  - id: exclude_groups
    type:
      - 'null'
      - string
    doc: Exclude these (taxonomic) groups (also works for 'other')
    inputBinding:
      position: 101
      prefix: --exclude
  - id: figure_format
    type:
      - 'null'
      - string
    doc: Figure format for plot (png, pdf, eps, jpeg, ps, svg, svgz, tiff)
    default: png
    inputBinding:
      position: 101
      prefix: --format
  - id: hide_nohit
    type:
      - 'null'
      - boolean
    doc: Hide sequences without taxonomic annotation
    default: false
    inputBinding:
      position: 101
      prefix: --nohit
  - id: histogram_data
    type:
      - 'null'
      - string
    doc: 'Data for histograms (span: span-weighted histograms, count: count histograms)'
    default: span
    inputBinding:
      position: 101
      prefix: --hist
  - id: max_axis_value
    type:
      - 'null'
      - float
    doc: Maximum values for x/y-axis
    default: '1e10'
    inputBinding:
      position: 101
      prefix: --max
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length considered for plotting
    default: 100
    inputBinding:
      position: 101
      prefix: --length
  - id: multiplot
    type:
      - 'null'
      - boolean
    doc: Multi-plot. Print blobplot for each (taxonomic) group separately
    inputBinding:
      position: 101
      prefix: --multiplot
  - id: no_scale_by_length
    type:
      - 'null'
      - boolean
    doc: Do not scale sequences by length
    default: false
    inputBinding:
      position: 101
      prefix: --noscale
  - id: no_title
    type:
      - 'null'
      - boolean
    doc: Do not add filename as title to plot
    inputBinding:
      position: 101
      prefix: --notitle
  - id: omit_blobplot
    type:
      - 'null'
      - boolean
    doc: Omit blobplot
    default: false
    inputBinding:
      position: 101
      prefix: --noblobs
  - id: omit_read_plot
    type:
      - 'null'
      - boolean
    doc: Omit plot of reads mapping
    default: false
    inputBinding:
      position: 101
      prefix: --noreads
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: plot_legend
    type:
      - 'null'
      - boolean
    doc: Plot legend of blobplot in separate figure
    inputBinding:
      position: 101
      prefix: --legend
  - id: plotgroups
    type:
      - 'null'
      - int
    doc: Number of (taxonomic) groups to plot, remaining groups are placed in 
      'other'
    default: 7
    inputBinding:
      position: 101
      prefix: --plotgroups
  - id: refcov_file
    type:
      - 'null'
      - File
    doc: 'File containing number of "total" and "mapped" reads per coverage file.
      (e.g.: bam0,900,100). If provided, info will be used in read coverage plot(s).'
    inputBinding:
      position: 101
      prefix: --refcov
  - id: relabel_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: Relabel (taxonomic) groups, can be used several times. e.g. 
      "A=Actinobacteria,Proteobacteria"
    inputBinding:
      position: 101
      prefix: --label
  - id: sort_first_labels
    type:
      - 'null'
      - string
    doc: Labels that should always be plotted first, regardless of sort order
    inputBinding:
      position: 101
      prefix: --sort_first
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'Sort order for plotting (span: plot with decreasing span, count: plot with
      decreasing count)'
    default: span
    inputBinding:
      position: 101
      prefix: --sort
  - id: taxonomic_rank
    type:
      - 'null'
      - string
    doc: Taxonomic rank used for colouring of blobs
    default: phylum
    inputBinding:
      position: 101
      prefix: --rank
  - id: taxrule
    type:
      - 'null'
      - string
    doc: Taxrule which has been used for computing taxonomy
    default: bestsum
    inputBinding:
      position: 101
      prefix: --taxrule
  - id: xlabel
    type:
      - 'null'
      - string
    doc: Label for x-axis
    inputBinding:
      position: 101
      prefix: --xlabel
  - id: ylabel
    type:
      - 'null'
      - string
    doc: Label for y-axis
    inputBinding:
      position: 101
      prefix: --ylabel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtools:1.1.1--py_1
stdout: blobtools_covplot.out
