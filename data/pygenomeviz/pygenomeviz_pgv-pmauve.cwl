cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgv-pmauve
label: pygenomeviz_pgv-pmauve
doc: "pyGenomeViz CLI utility for visualization workflow using progressiveMauve\n\nTool homepage: https://github.com/moshi4/pyGenomeViz/"
inputs:
  - id: seq_files
    type: File[]
    doc: "Input genome sequence files (Genbank or Fasta format)"
    inputBinding:
      position: 1
      prefix: --seq_files
  - id: outdir
    type: string
    doc: "Output directory"
    inputBinding:
      position: 2
      prefix: --outdir
  - id: refid
    type: ['null', int]
    doc: "Reference genome index (Default: 0)"
    inputBinding:
      position: 3
      prefix: --refid
  - id: format
    type: ['null', {type: array, items: string}]
    doc: "Output image format ('png'|'jpg'|'svg'|'pdf'|'html')"
    inputBinding:
      position: 110
      prefix: --format
  - id: reuse
    type: ['null', boolean]
    doc: "Reuse previous result if available"
    inputBinding:
      position: 111
      prefix: --reuse
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
  - id: link_track_ratio
    type: ['null', float]
    doc: "Link track ratio (Default: 5.0)"
    inputBinding:
      position: 101
      prefix: --link_track_ratio
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
  - id: normal_link_color
    type: ['null', string]
    doc: "Normal link color (Default: 'grey')"
    inputBinding:
      position: 101
      prefix: --normal_link_color
  - id: inverted_link_color
    type: ['null', string]
    doc: "Inverted link color (Default: 'tomato')"
    inputBinding:
      position: 101
      prefix: --inverted_link_color
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
  - id: plotstyle
    type: ['null', string]
    doc: "Block box plot style ('box'|'bigbox')"
    inputBinding:
      position: 170
      prefix: --plotstyle
  - id: cmap
    type: ['null', string]
    doc: "Block box colormap (Default: 'hsv')"
    inputBinding:
      position: 171
      prefix: --cmap
  - id: curve
    type: ['null', boolean]
    doc: "Plot curved style link (Default: OFF)"
    inputBinding:
      position: 189
      prefix: --curve
  - id: dpi
    type: ['null', int]
    doc: "Figure DPI (Default: 300)"
    inputBinding:
      position: 190
      prefix: --dpi
outputs:
  - id: out_dir
    type: Directory
    doc: "Output directory with the plots and progressiveMauve results"
    outputBinding:
      glob: "$(inputs.outdir)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
