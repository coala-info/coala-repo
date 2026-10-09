cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - plot-cn
label: hatchet_plot_cn
doc: "Plot the inferred copy numbers, clone proportions and clone profiles from one or more files in CN_BBC (.ucn) format.

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "One or more files in CN_BBC format (e.g., results/best.bbc.ucn)"
    inputBinding:
      position: 100
  - id: patientnames
    type:
      - 'null'
      - string
    doc: "One or more space-separated patient names (default: inferred from filenames)"
    inputBinding:
      position: 10
      prefix: -n
  - id: minu
    type:
      - 'null'
      - float
    doc: "Minimum proportion of a CNA to be considered subclonal (default: 0.2)"
    inputBinding:
      position: 10
      prefix: -u
  - id: rundir
    type: string
    doc: Running directory where the plots are written (created in the working directory)
    inputBinding:
      position: 10
      prefix: -x
    default: evaluation
  - id: basecn
    type:
      - 'null'
      - int
    doc: "Base copy number (default: inferred from tumor ploidy)"
    inputBinding:
      position: 10
      prefix: -b
  - id: figsizeclones
    type:
      - 'null'
      - string
    doc: "Size of clone plots in the form \"(X-SIZE, Y-SIZE)\""
    inputBinding:
      position: 10
      prefix: -sC
  - id: figsizecn
    type:
      - 'null'
      - string
    doc: "Size of CN plots in the form \"(X-SIZE, Y-SIZE)\""
    inputBinding:
      position: 10
      prefix: -sP
  - id: figsizegrid
    type:
      - 'null'
      - string
    doc: "Size of grid plots in the form \"(X-SIZE, Y-SIZE)\""
    inputBinding:
      position: 10
      prefix: -sG
  - id: resolutionclones
    type:
      - 'null'
      - int
    doc: "Number of bins to merge together for plotting clone profiles (default: 100)"
    inputBinding:
      position: 10
      prefix: -rC
  - id: resolutioncn
    type:
      - 'null'
      - int
    doc: "Number of bins to merge together for plotting proportions (default: 500)"
    inputBinding:
      position: 10
      prefix: -rP
  - id: resolutiongrid
    type:
      - 'null'
      - int
    doc: "Number of bins to merge together in grids (default: 100)"
    inputBinding:
      position: 10
      prefix: -rG
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Threshold used to classify a tumor into either diploid or tetraploid (default: 3.0)"
    inputBinding:
      position: 10
      prefix: -e
  - id: ymax
    type:
      - 'null'
      - float
    doc: "Maximum values in y-axis (default: automatically inferred)"
    inputBinding:
      position: 10
      prefix: --ymax
  - id: ymin
    type:
      - 'null'
      - float
    doc: "Minimum values in y-axis (default: automatically inferred)"
    inputBinding:
      position: 10
      prefix: --ymin
  - id: clonepalette
    type:
      - 'null'
      - string
    doc: "Palette for coloring the clones among Set1, Set2, Set3, Paired (default: Set1)"
    inputBinding:
      position: 10
      prefix: --clonepalette
  - id: linkage
    type:
      - 'null'
      - string
    doc: "Linkage method used for clustering: single, complete, average, weighted, centroid, median, ward (default: single)"
    inputBinding:
      position: 10
      prefix: --linkage
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
