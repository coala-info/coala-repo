cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgv-mummer
label: pygenomeviz_pgv-mummer
doc: "pyGenomeViz CLI utility for visualization workflow using MUMmer\n\nTool homepage: https://github.com/moshi4/pyGenomeViz/"
inputs:
  - id: gbk_resources
    type: File[]
    doc: "Input genome genbank file resources"
    inputBinding:
      position: 1
      prefix: --gbk_resources
  - id: outdir
    type: string
    doc: "Output directory"
    inputBinding:
      position: 2
      prefix: --outdir
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
  - id: seqtype
    type: ['null', string]
    doc: "MUMmer alignment sequence type ('protein'|'nucleotide')"
    inputBinding:
      position: 120
      prefix: --seqtype
  - id: min_length
    type: ['null', int]
    doc: "Min-length threshold to be plotted (Default: 0)"
    inputBinding:
      position: 121
      prefix: --min_length
  - id: min_identity
    type: ['null', float]
    doc: "Min-identity threshold to be plotted (Default: 0)"
    inputBinding:
      position: 122
      prefix: --min_identity
  - id: thread_num
    type: ['null', int]
    doc: "Threads number parameter (Default: MaxThread - 1)"
    inputBinding:
      position: 123
      prefix: --thread_num
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
    doc: "Inverted link color (Default: 'red')"
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
  - id: pseudo
    type: ['null', boolean]
    doc: "Show pseudogene feature"
    inputBinding:
      position: 170
      prefix: --pseudo
  - id: pseudo_color
    type: ['null', string]
    doc: "Pseudogene feature color (Default: 'grey')"
    inputBinding:
      position: 171
      prefix: --pseudo_color
  - id: colorbar_width
    type: ['null', float]
    doc: "Colorbar width (Default: 0.01)"
    inputBinding:
      position: 180
      prefix: --colorbar_width
  - id: colorbar_height
    type: ['null', float]
    doc: "Colorbar height (Default: 0.2)"
    inputBinding:
      position: 181
      prefix: --colorbar_height
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
    doc: "Output directory with the plots and MUMmer results"
    outputBinding:
      glob: "$(inputs.outdir)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenomeviz:0.4.4--pyhdfd78af_0
