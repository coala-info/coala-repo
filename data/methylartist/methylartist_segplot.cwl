cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - segplot
label: methylartist_segplot
doc: "Generate segmentation plots from methylartist segmeth output\n\nTool homepage:
  https://github.com/adamewing/methylartist"
inputs:
  - id: categories
    type:
      - 'null'
      - string
    doc: categories, comma delimited, need to match seg_name column from input
    inputBinding:
      position: 101
      prefix: --categories
  - id: group_by_annotation
    type:
      - 'null'
      - boolean
    doc: group plots by annotation rather than by sample
    inputBinding:
      position: 101
      prefix: --group_by_annotation
  - id: height
    type:
      - 'null'
      - float
    doc: figure height
    default: 6
    inputBinding:
      position: 101
      prefix: --height
  - id: max
    type:
      - 'null'
      - float
    doc: max value for plot
    default: 1.15
    inputBinding:
      position: 101
      prefix: --max
  - id: metadata
    type:
      - 'null'
      - File
    doc: sample metadata (tab-delimited with header, sample name as first 
      column)
    inputBinding:
      position: 101
      prefix: --metadata
  - id: min
    type:
      - 'null'
      - float
    doc: min value for plot
    default: -0.15
    inputBinding:
      position: 101
      prefix: --min
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality (mapq)
    default: 10
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: mincalls
    type:
      - 'null'
      - int
    doc: minimum number of calls to include site (methylated + unmethylated)
    default: 10
    inputBinding:
      position: 101
      prefix: --mincalls
  - id: minreads
    type:
      - 'null'
      - int
    doc: minimum reads in interval
    default: 1
    inputBinding:
      position: 101
      prefix: --minreads
  - id: mods
    type:
      - 'null'
      - string
    doc: mods, comma delimited
    inputBinding:
      position: 101
      prefix: --mods
  - id: palette
    type:
      - 'null'
      - string
    doc: palette, see https://seaborn.pydata.org/tutorial/color_palettes.html
    default: tab10
    inputBinding:
      position: 101
      prefix: --palette
  - id: pointsize
    type:
      - 'null'
      - float
    doc: point size for scatterplot
    default: 1
    inputBinding:
      position: 101
      prefix: --pointsize
  - id: ridge
    type:
      - 'null'
      - boolean
    doc: Enable ridge plot
    inputBinding:
      position: 101
      prefix: --ridge
  - id: ridge_alpha
    type:
      - 'null'
      - float
    doc: alpha (tranparency) for ridge plot fills
    default: 1.0
    inputBinding:
      position: 101
      prefix: --ridge_alpha
  - id: ridge_smoothing
    type:
      - 'null'
      - float
    doc: smoothing parameter for ridge plot, bigger is smoother
    default: 0.5
    inputBinding:
      position: 101
      prefix: --ridge_smoothing
  - id: ridge_spacing
    type:
      - 'null'
      - float
    doc: ridge plot spacing (generally negative)
    default: -0.25
    inputBinding:
      position: 101
      prefix: --ridge_spacing
  - id: samples
    type:
      - 'null'
      - string
    doc: samples, comma delimited
    inputBinding:
      position: 101
      prefix: --samples
  - id: segmeth
    type: File
    doc: output from segmeth.py
    inputBinding:
      position: 101
      prefix: --segmeth
  - id: svg
    type:
      - 'null'
      - boolean
    doc: Output in SVG format
    inputBinding:
      position: 101
      prefix: --svg
  - id: tiltlabel
    type:
      - 'null'
      - boolean
    doc: Tilt labels
    inputBinding:
      position: 101
      prefix: --tiltlabel
  - id: usemeta
    type:
      - 'null'
      - string
    doc: metadata to append to annotation (comma-delimited)
    inputBinding:
      position: 101
      prefix: --usemeta
  - id: vertlabel
    type:
      - 'null'
      - boolean
    doc: Vertical labels
    inputBinding:
      position: 101
      prefix: --vertlabel
  - id: violin
    type:
      - 'null'
      - boolean
    doc: Enable violin plot
    inputBinding:
      position: 101
      prefix: --violin
  - id: width
    type:
      - 'null'
      - float
    doc: figure width (default = automatic)
    inputBinding:
      position: 101
      prefix: --width
  - id: ylabel
    type:
      - 'null'
      - string
    doc: set label for y-axis
    default: pct methylation
    inputBinding:
      position: 101
      prefix: --ylabel
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: 'output file name (default: generated from input)'
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
