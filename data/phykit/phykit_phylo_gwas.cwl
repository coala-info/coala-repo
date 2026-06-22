cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - phylo_gwas
label: phykit_phylo_gwas
doc: Phylogenetic genome-wide association study following the Pease et al. 
  (2016) approach. Performs per-site association tests between alignment columns
  and a phenotype, applies Benjamini-Hochberg FDR correction, and optionally 
  classifies associations using a phylogenetic tree.
inputs:
  - id: alignment
    type: File
    doc: FASTA alignment file
    inputBinding:
      position: 101
      prefix: --alignment
  - id: phenotype
    type:
      - 'null'
      - File
    doc: 'two-column TSV file: taxon<tab>phenotype'
    inputBinding:
      position: 101
      prefix: --phenotype
  - id: output
    type: string
    doc: output Manhattan plot path
    inputBinding:
      position: 101
      prefix: --output
  - id: tree
    type:
      - 'null'
      - File
    doc: optional Newick tree for monophyletic/polyphyletic classification
    inputBinding:
      position: 101
      prefix: --tree
  - id: partition
    type:
      - 'null'
      - File
    doc: optional RAxML-style partition file for gene annotations
    inputBinding:
      position: 101
      prefix: --partition
  - id: alpha
    type:
      - 'null'
      - float
    doc: FDR significance threshold
    inputBinding:
      position: 101
      prefix: --alpha
  - id: exclude_monophyletic
    type:
      - 'null'
      - boolean
    doc: exclude monophyletic associations from results
    inputBinding:
      position: 101
      prefix: --exclude-monophyletic
  - id: dot_size
    type:
      - 'null'
      - float
    doc: scale factor for dot size in the Manhattan plot
    inputBinding:
      position: 101
      prefix: --dot-size
  - id: csv
    type: string
    doc: output per-site results as CSV to the specified file
    inputBinding:
      position: 101
      prefix: --csv
  - id: fig_width
    type:
      - 'null'
      - float
    doc: figure width in inches (auto-scaled if omitted)
    inputBinding:
      position: 101
      prefix: --fig-width
  - id: fig_height
    type:
      - 'null'
      - float
    doc: figure height in inches (auto-scaled if omitted)
    inputBinding:
      position: 101
      prefix: --fig-height
  - id: dpi
    type:
      - 'null'
      - int
    doc: resolution in DPI
    inputBinding:
      position: 101
      prefix: --dpi
  - id: no_title
    type:
      - 'null'
      - boolean
    doc: hide the plot title
    inputBinding:
      position: 101
      prefix: --no-title
  - id: title
    type:
      - 'null'
      - string
    doc: custom title text
    inputBinding:
      position: 101
      prefix: --title
  - id: legend_position
    type:
      - 'null'
      - string
    doc: legend location (e.g., 'upper right', 'none')
    inputBinding:
      position: 101
      prefix: --legend-position
  - id: ylabel_fontsize
    type:
      - 'null'
      - int
    doc: font size for y-axis labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --ylabel-fontsize
  - id: xlabel_fontsize
    type:
      - 'null'
      - int
    doc: font size for x-axis labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --xlabel-fontsize
  - id: title_fontsize
    type:
      - 'null'
      - int
    doc: font size for the title
    inputBinding:
      position: 101
      prefix: --title-fontsize
  - id: axis_fontsize
    type:
      - 'null'
      - int
    doc: font size for axis labels
    inputBinding:
      position: 101
      prefix: --axis-fontsize
  - id: colors
    type:
      - 'null'
      - string
    doc: comma-separated colors (hex or named)
    inputBinding:
      position: 101
      prefix: --colors
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 101
      prefix: --json
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
  - id: output_output
    type: File
    doc: output Manhattan plot path
    outputBinding:
      glob: $(inputs.output)
  - id: output_csv
    type:
      - 'null'
      - File
    doc: output per-site results as CSV to the specified file
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
