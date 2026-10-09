cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - plot-bins
label: hatchet_plot_bins
doc: "Generate plots for read-depth ratio (RD), B-allele frequency (BAF), and clusters for genomic bins in multiple samples using .bb, .cbb, .seg files.

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: input
    type: File
    doc: Input BBC file with RDR and BAF
    inputBinding:
      position: 100
  - id: command
    type:
      - 'null'
      - string
    doc: "The plots to generate: RD, CRD, BAF, CBAF, BB, CBB or CLUSTER (default: all)"
    inputBinding:
      position: 10
      prefix: -c
  - id: segfile
    type:
      - 'null'
      - File
    doc: "When the corresponding seg file is provided the clusters are also plotted (default: none)"
    inputBinding:
      position: 10
      prefix: -s
  - id: colormap
    type:
      - 'null'
      - string
    doc: "Colormap to use for the colors in the plots: Set1, Set2, Paired, Dark2, tab10, tab20"
    inputBinding:
      position: 10
      prefix: -m
  - id: chrthreshold
    type:
      - 'null'
      - int
    doc: "Only covering at least this number of chromosomes are considered (default: None)"
    inputBinding:
      position: 10
      prefix: -tC
  - id: sizethreshold
    type:
      - 'null'
      - float
    doc: "Only covering at least this genome proportion (default: None)"
    inputBinding:
      position: 10
      prefix: -tS
  - id: resolution
    type:
      - 'null'
      - int
    doc: "Resolution of bins (default: bins are not merged)"
    inputBinding:
      position: 10
      prefix: --resolution
  - id: xmin
    type:
      - 'null'
      - float
    doc: "Minimum value on x-axis for supported plots (default: inferred from data)"
    inputBinding:
      position: 10
      prefix: --xmin
  - id: xmax
    type:
      - 'null'
      - float
    doc: "Maximum value on x-axis for supported plots (default: inferred from data)"
    inputBinding:
      position: 10
      prefix: --xmax
  - id: ymin
    type:
      - 'null'
      - float
    doc: "Minimum value on y-axis for supported plots (default: inferred from data)"
    inputBinding:
      position: 10
      prefix: --ymin
  - id: ymax
    type:
      - 'null'
      - float
    doc: "Maximum value on y-axis for supported plots (default: inferred from data)"
    inputBinding:
      position: 10
      prefix: --ymax
  - id: figsize
    type:
      - 'null'
      - string
    doc: "Size of the plotted figures in the form \"(X-SIZE, Y-SIZE)\""
    inputBinding:
      position: 10
      prefix: --figsize
  - id: markersize
    type:
      - 'null'
      - float
    doc: "Size of the markers (default: values inferred for each plot)"
    inputBinding:
      position: 10
      prefix: --markersize
  - id: colwrap
    type:
      - 'null'
      - int
    doc: "Wrapping the plots in this number of columns (default: 2)"
    inputBinding:
      position: 10
      prefix: --colwrap
  - id: fontscale
    type:
      - 'null'
      - float
    doc: "Font scale (default: 1)"
    inputBinding:
      position: 10
      prefix: --fontscale
  - id: rundir
    type: string
    doc: Running directory where the results are written (created in the working directory)
    inputBinding:
      position: 10
      prefix: -x
    default: plots
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: "Output the figures in PDF format (default: PNG)"
    inputBinding:
      position: 10
      prefix: --pdf
  - id: dpi
    type:
      - 'null'
      - int
    doc: "DPI of PNG images (default: 900)"
    inputBinding:
      position: 10
      prefix: --dpi
outputs:
  - id: plots_dir
    type: Directory
    doc: Directory with the plots
    outputBinding:
      glob: $(inputs.rundir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.rundir)
        entry: '$({"class": "Directory", "basename": inputs.rundir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
