cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgv-simpleplot
label: pygenomeviz_pgv-simpleplot
doc: "pyGenomeViz CLI utility for visualization workflow\n\nTool homepage: https://github.com/moshi4/pyGenomeViz/"
inputs:
  - id: gbk_resources
    type: File[]
    doc: "Input genome genbank file resources"
    inputBinding:
      position: 1
      prefix: --gbk_resources
  - id: outfile
    type: string
    doc: "Output file ('*.png'|'*.jpg'|'*.svg'|'*.pdf'|'*.html')"
    inputBinding:
      position: 2
      prefix: --outfile
  - id: fig_width
    type: ['null', float]
    doc: "Figure width (Default: 15)"
    inputBinding:
      position: 101
      prefix: --fig_width
  - id: fig_track_height
    type: ['null', float]
    doc: "Figure track height (Default: 1.0)"
    inputBinding:
      position: 101
      prefix: --fig_track_height
  - id: feature_track_ratio
    type: ['null', float]
    doc: "Feature track ratio (Default: 1.0)"
    inputBinding:
      position: 101
      prefix: --feature_track_ratio
  - id: space_track_ratio
    type: ['null', float]
    doc: "Space (b/w feature) track ratio (Default: 2.0)"
    inputBinding:
      position: 101
      prefix: --space_track_ratio
  - id: tick_track_ratio
    type: ['null', float]
    doc: "Tick track ratio (Default: 1.0)"
    inputBinding:
      position: 101
      prefix: --tick_track_ratio
  - id: track_labelsize
    type: ['null', int]
    doc: "Track label size (Default: 20)"
    inputBinding:
      position: 101
      prefix: --track_labelsize
  - id: tick_labelsize
    type: ['null', int]
    doc: "Tick label size (Default: 15)"
    inputBinding:
      position: 101
      prefix: --tick_labelsize
  - id: align_type
    type: ['null', string]
    doc: "Figure tracks align type"
    inputBinding:
      position: 101
      prefix: --align_type
  - id: tick_style
    type: ['null', string]
    doc: "Tick style ('bar'|'axis'|None)"
    inputBinding:
      position: 101
      prefix: --tick_style
  - id: feature_plotstyle
    type: ['null', string]
    doc: "Feature plot style ('bigarrow'|'arrow')"
    inputBinding:
      position: 101
      prefix: --feature_plotstyle
  - id: arrow_shaft_ratio
    type: ['null', float]
    doc: "Feature arrow shaft ratio (Default: 0.5)"
    inputBinding:
      position: 101
      prefix: --arrow_shaft_ratio
  - id: feature_color
    type: ['null', string]
    doc: "Feature color (Default: 'orange')"
    inputBinding:
      position: 101
      prefix: --feature_color
  - id: feature_linewidth
    type: ['null', float]
    doc: "Feature edge line width (Default: 0.0)"
    inputBinding:
      position: 101
      prefix: --feature_linewidth
  - id: dpi
    type: ['null', int]
    doc: "Figure DPI (Default: 300)"
    inputBinding:
      position: 190
      prefix: --dpi
outputs:
  - id: out_figure
    type: File
    doc: "Plot written to outfile"
    outputBinding:
      glob: "$(inputs.outfile)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
