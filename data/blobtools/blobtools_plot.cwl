cwlVersion: v1.2
class: CommandLineTool
baseCommand: blobtools_plot
label: blobtools_plot
doc: "Plotting tool for BlobDB files.\n\nTool homepage: https://blobtools.readme.io/docs/what-is-blobtools"
inputs:
  - id: catcolour
    type:
      - 'null'
      - File
    doc: 'Colour plot based on categories from FILE (format : "seq\tcategory")'
    inputBinding:
      position: 101
      prefix: --catcolour
  - id: cindex
    type:
      - 'null'
      - boolean
    doc: Colour blobs by 'c index'
    inputBinding:
      position: 101
      prefix: --cindex
  - id: colours
    type:
      - 'null'
      - File
    doc: File containing colours for (taxonomic) groups. This allows having more
      than 9 colours.
    inputBinding:
      position: 101
      prefix: --colours
  - id: covlib
    type:
      - 'null'
      - string
    doc: Plot only certain covlib(s). Separated by ","
    inputBinding:
      position: 101
      prefix: --lib
  - id: cumulative
    type:
      - 'null'
      - boolean
    doc: Print plot after addition of each (taxonomic) group
    inputBinding:
      position: 101
      prefix: --cumulative
  - id: exclude
    type:
      - 'null'
      - File
    doc: Exclude these (taxonomic) groups (also works for 'other')
    inputBinding:
      position: 101
      prefix: --exclude
  - id: filelabel
    type:
      - 'null'
      - boolean
    doc: Label axis based on filenames
    inputBinding:
      position: 101
      prefix: --filelabel
  - id: format
    type:
      - 'null'
      - string
    doc: Figure format for plot (png, pdf, eps, jpeg, ps, svg, svgz, tiff)
    inputBinding:
      position: 101
      prefix: --format
  - id: hist
    type:
      - 'null'
      - string
    doc: Data for histograms
    inputBinding:
      position: 101
      prefix: --hist
  - id: infile
    type: File
    doc: BlobDB file (created with "blobtools create")
    inputBinding:
      position: 101
      prefix: --infile
  - id: label
    type:
      - 'null'
      - type: array
        items: string
    doc: Relabel (taxonomic) groups, can be used several times. e.g. 
      "A=Actinobacteria,Proteobacteria"
    inputBinding:
      position: 101
      prefix: --label
  - id: legend
    type:
      - 'null'
      - boolean
    doc: Plot legend of blobplot in separate figure
    inputBinding:
      position: 101
      prefix: --legend
  - id: length
    type:
      - 'null'
      - int
    doc: Minimum sequence length considered for plotting
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
  - id: multiplot
    type:
      - 'null'
      - boolean
    doc: Multi-plot. Print blobplot for each (taxonomic) group separately
    inputBinding:
      position: 101
      prefix: --multiplot
  - id: noblobs
    type:
      - 'null'
      - boolean
    doc: Omit blobplot
    inputBinding:
      position: 101
      prefix: --noblobs
  - id: nohit
    type:
      - 'null'
      - boolean
    doc: Hide sequences without taxonomic annotation
    inputBinding:
      position: 101
      prefix: --nohit
  - id: noreads
    type:
      - 'null'
      - boolean
    doc: Omit plot of reads mapping
    inputBinding:
      position: 101
      prefix: --noreads
  - id: noscale
    type:
      - 'null'
      - boolean
    doc: Do not scale sequences by length
    inputBinding:
      position: 101
      prefix: --noscale
  - id: notitle
    type:
      - 'null'
      - boolean
    doc: Do not add filename as title to plot
    inputBinding:
      position: 101
      prefix: --notitle
  - id: plotgroups
    type:
      - 'null'
      - int
    doc: Number of (taxonomic) groups to plot, remaining groups are placed in 
      'other'
    inputBinding:
      position: 101
      prefix: --plotgroups
  - id: rank
    type:
      - 'null'
      - string
    doc: Taxonomic rank used for colouring of blobs
    inputBinding:
      position: 101
      prefix: --rank
  - id: refcov
    type:
      - 'null'
      - File
    doc: 'File containing number of "total" and "mapped" reads per coverage file.
      (e.g.: bam0,900,100). If provided, info will be used in read coverage plot(s).'
    inputBinding:
      position: 101
      prefix: --refcov
  - id: sort
    type:
      - 'null'
      - string
    doc: Sort order for plotting
    inputBinding:
      position: 101
      prefix: --sort
  - id: sort_first
    type:
      - 'null'
      - string
    doc: Labels that should always be plotted first, regardless of sort order
    inputBinding:
      position: 101
      prefix: --sort_first
  - id: taxrule
    type:
      - 'null'
      - string
    doc: Taxrule which has been used for computing taxonomy
    inputBinding:
      position: 101
      prefix: --taxrule
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output prefix
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtools:1.1.1--py_1
