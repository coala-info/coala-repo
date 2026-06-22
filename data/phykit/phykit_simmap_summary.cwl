cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - simmap_summary
label: phykit_simmap_summary
doc: Run N stochastic character maps and summarize per-branch dwelling time 
  proportions, expected transitions, and posterior state probabilities at each 
  node. This extends stochastic_character_map by providing a detailed per-branch
  summary analogous to phytools::describe.simmap() in R.
inputs:
  - id: tree
    type: File
    doc: phylogenetic tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: trait_data
    type:
      - 'null'
      - File
    doc: tab-delimited trait file with header row
    inputBinding:
      position: 101
      prefix: --trait_data
  - id: trait
    type: string
    doc: column name for the discrete character trait
    inputBinding:
      position: 101
      prefix: --trait
  - id: model
    type:
      - 'null'
      - string
    doc: 'substitution model: ER (equal rates), SYM (symmetric), or ARD (all rates
      different).'
    inputBinding:
      position: 101
      prefix: --model
  - id: nsim
    type:
      - 'null'
      - int
    doc: number of stochastic maps to simulate
    inputBinding:
      position: 101
      prefix: --nsim
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for reproducibility
    inputBinding:
      position: 101
      prefix: --seed
  - id: plot
    type: string
    doc: output plot file showing tree with posterior pie charts at nodes
    inputBinding:
      position: 101
      prefix: --plot
  - id: csv
    type: string
    doc: output CSV file with per-branch dwelling proportions and node 
      posteriors
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
      - string
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
  - id: output_plot
    type:
      - 'null'
      - File
    doc: output plot file showing tree with posterior pie charts at nodes
    outputBinding:
      glob: $(inputs.plot)
  - id: output_csv
    type:
      - 'null'
      - File
    doc: output CSV file with per-branch dwelling proportions and node 
      posteriors
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
