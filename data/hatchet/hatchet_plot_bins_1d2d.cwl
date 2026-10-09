cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - plot-bins-1d2d
label: hatchet_plot_bins_1d2d
doc: "Plot one- and two-dimensional views of the read-depth ratio and mirrored B-allele frequency of the bins in a BBC table.

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: bbc
    type: File
    doc: "Filename for BBC table (e.g., bbc/bulk.bbc)"
    inputBinding:
      position: 10
      prefix: -b
  - id: seg
    type:
      - 'null'
      - File
    doc: "Filename for SEG table (e.g., bbc/bulk.seg), required to show cluster centers"
    inputBinding:
      position: 10
      prefix: -s
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
    doc: "Axis limits for mirrored BAF as comma-separated values, e.g., '0,0.51' (default: full range of data)"
    inputBinding:
      position: 10
      prefix: --baflim
  - id: rdrlim
    type:
      - 'null'
      - string
    doc: "Axis limits for read-depth ratio as comma-separated values, e.g., '0,3' (default: full range of data)"
    inputBinding:
      position: 10
      prefix: --rdrlim
  - id: centers
    type:
      - 'null'
      - boolean
    doc: Show cluster centers (requires the SEG file)
    inputBinding:
      position: 10
      prefix: --centers
  - id: centromeres
    type:
      - 'null'
      - boolean
    doc: Mark centromere locations with grey rectangles
    inputBinding:
      position: 10
      prefix: --centromeres
  - id: alpha
    type:
      - 'null'
      - float
    doc: Opacity alpha (default 1)
    inputBinding:
      position: 10
      prefix: -a
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
