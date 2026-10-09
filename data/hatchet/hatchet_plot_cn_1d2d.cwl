cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - plot-cn-1d2d
label: hatchet_plot_cn_1d2d
doc: "Plot one- and two-dimensional views of the fractional copy numbers and mirrored B-allele frequency from a BBC table with copy numbers.

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: input
    type: File
    doc: "Filename for BBC table (e.g., results/best.bbc.ucn)"
    inputBinding:
      position: 100
  - id: outdir
    type: string
    doc: Directory for output files (created in the working directory)
    inputBinding:
      position: 10
      prefix: -O
  - id: baflim
    type:
      - 'null'
      - string
    doc: "Axis limits for mirrored BAF values as comma-separated values, e.g., '0,0.51' (default: full range of data)"
    inputBinding:
      position: 10
      prefix: --baflim
  - id: fcnlim
    type:
      - 'null'
      - string
    doc: "Axis limits for fractional copy number values as comma-separated values, e.g., '0,3' (default: full range of data)"
    inputBinding:
      position: 10
      prefix: --fcnlim
  - id: centromeres
    type:
      - 'null'
      - boolean
    doc: Mark centromere locations with grey rectangles
    inputBinding:
      position: 10
      prefix: --centromeres
  - id: bysample
    type:
      - 'null'
      - boolean
    doc: Write each sample to a separate file rather than combining all into 2 files
    inputBinding:
      position: 10
      prefix: --bysample
outputs:
  - id: plots_dir
    type: Directory
    doc: Directory with the plots
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({"class": "Directory", "basename": inputs.outdir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
