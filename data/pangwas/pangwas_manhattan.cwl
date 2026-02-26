cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - manhattan
label: pangwas_manhattan
doc: "Plot the distribution of variant p-values across the genome.\n\nTool homepage:
  https://github.com/phac-nml/pangwas"
inputs:
  - id: bed
    type: File
    doc: BED file with region coordinates and names.
    inputBinding:
      position: 101
      prefix: --bed
  - id: clusters
    type:
      - 'null'
      - type: array
        items: string
    doc: Only plot these clusters.
    default: all
    inputBinding:
      position: 101
      prefix: --clusters
  - id: font_family
    type:
      - 'null'
      - string
    doc: Font family of the tree labels.
    default: Roboto
    inputBinding:
      position: 101
      prefix: --font-family
  - id: font_size
    type:
      - 'null'
      - int
    doc: Font size of the tree labels.
    default: 16
    inputBinding:
      position: 101
      prefix: --font-size
  - id: gwas
    type: File
    doc: TSV table of variants from gwas subcommand.
    inputBinding:
      position: 101
      prefix: --gwas
  - id: height
    type:
      - 'null'
      - int
    doc: Plot height in pixels.
    inputBinding:
      position: 101
      prefix: --height
  - id: margin
    type:
      - 'null'
      - int
    doc: Margin sizes in pixels.
    default: 20
    inputBinding:
      position: 101
      prefix: --margin
  - id: max_blocks
    type:
      - 'null'
      - int
    doc: Maximum number of blocks to draw before switching to pangenome 
      coordinates.
    default: 20
    inputBinding:
      position: 101
      prefix: --max-blocks
  - id: png_scale
    type:
      - 'null'
      - float
    doc: Scaling factor of the PNG file.
    default: 2.0
    inputBinding:
      position: 101
      prefix: --png-scale
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: prop_x_axis
    type:
      - 'null'
      - boolean
    doc: Make x-axis proporional to genomic length.
    inputBinding:
      position: 101
      prefix: --prop-x-axis
  - id: syntenies
    type:
      - 'null'
      - type: array
        items: string
    doc: Only plot these synteny blocks.
    default: all
    inputBinding:
      position: 101
      prefix: --syntenies
  - id: variant_types
    type:
      - 'null'
      - type: array
        items: string
    doc: Only plot these variant types.
    default: all
    inputBinding:
      position: 101
      prefix: --variant-types
  - id: width
    type:
      - 'null'
      - int
    doc: Plot width in pixels.
    inputBinding:
      position: 101
      prefix: --width
  - id: ymax
    type:
      - 'null'
      - float
    doc: A -log10 value to use as the y axis max, to synchronize multiple plots.
    inputBinding:
      position: 101
      prefix: --ymax
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
