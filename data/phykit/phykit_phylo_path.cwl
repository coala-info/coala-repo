cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - phylo_path
label: phykit_phylo_path
doc: Phylogenetic path analysis (von Hardenberg & Gonzalez-Voyer 2013). Compare 
  competing causal DAGs using d-separation tests via PGLS with Pagel's lambda, 
  rank models by CICc, and estimate model-averaged path coefficients.
inputs:
  - id: tree
    type: File
    doc: species tree
    inputBinding:
      position: 101
      prefix: --tree
  - id: traits
    type:
      - 'null'
      - File
    doc: TSV file with taxon and continuous trait columns
    inputBinding:
      position: 101
      prefix: --traits
  - id: models
    type:
      - 'null'
      - File
    doc: 'model definition file with candidate DAGs. Format: name: A->B, B->C, ...'
    inputBinding:
      position: 101
      prefix: --models
  - id: best_only
    type:
      - 'null'
      - boolean
    doc: 'report only best model coefficients (default: model averaging)'
    inputBinding:
      position: 101
      prefix: --best-only
  - id: plot_output
    type: string
    doc: output DAG plot file
    inputBinding:
      position: 101
      prefix: --plot-output
  - id: csv
    type: string
    doc: output CSV with model comparison and path coefficients
    inputBinding:
      position: 101
      prefix: --csv
  - id: json
    type:
      - 'null'
      - boolean
    doc: output results as JSON
    inputBinding:
      position: 101
      prefix: --json
  - id: fig_width
    type:
      - 'null'
      - float
    doc: Figure width in inches (auto-scaled if omitted)
    inputBinding:
      position: 101
      prefix: --fig-width
  - id: fig_height
    type:
      - 'null'
      - float
    doc: Figure height in inches (auto-scaled if omitted)
    inputBinding:
      position: 101
      prefix: --fig-height
  - id: dpi
    type:
      - 'null'
      - int
    doc: Resolution in DPI
    inputBinding:
      position: 101
      prefix: --dpi
  - id: no_title
    type:
      - 'null'
      - boolean
    doc: Hide the plot title
    inputBinding:
      position: 101
      prefix: --no-title
  - id: title
    type:
      - 'null'
      - string
    doc: Custom title text
    inputBinding:
      position: 101
      prefix: --title
  - id: legend_position
    type:
      - 'null'
      - string
    doc: Legend location (e.g., 'upper right', 'none' to hide)
    inputBinding:
      position: 101
      prefix: --legend-position
  - id: ylabel_fontsize
    type:
      - 'null'
      - int
    doc: Font size for y-axis labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --ylabel-fontsize
  - id: xlabel_fontsize
    type:
      - 'null'
      - int
    doc: Font size for x-axis labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --xlabel-fontsize
  - id: title_fontsize
    type:
      - 'null'
      - int
    doc: Font size for the title
    inputBinding:
      position: 101
      prefix: --title-fontsize
  - id: axis_fontsize
    type:
      - 'null'
      - int
    doc: Font size for axis labels
    inputBinding:
      position: 101
      prefix: --axis-fontsize
  - id: colors
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated colors (hex or named)
    inputBinding:
      position: 101
      prefix: --colors
  - id: ladderize
    type:
      - 'null'
      - boolean
    doc: Ladderize (sort) the tree before plotting
    inputBinding:
      position: 101
      prefix: --ladderize
  - id: cladogram
    type:
      - 'null'
      - boolean
    doc: Draw cladogram (equal branch lengths, tips aligned) instead of 
      phylogram
    inputBinding:
      position: 101
      prefix: --cladogram
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Draw circular (radial/fan) phylogram instead of rectangular
    inputBinding:
      position: 101
      prefix: --circular
  - id: color_file
    type:
      - 'null'
      - File
    doc: Color annotation file for tip labels, clade ranges, and branch colors
    inputBinding:
      position: 101
      prefix: --color-file
outputs:
  - id: output_plot_output
    type:
      - 'null'
      - File
    doc: output DAG plot file
    outputBinding:
      glob: $(inputs.plot_output)
  - id: output_csv
    type:
      - 'null'
      - File
    doc: output CSV with model comparison and path coefficients
    outputBinding:
      glob: $(inputs.csv)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
