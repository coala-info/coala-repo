cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooler
  - show
label: cooler_show
doc: "Display and browse a cooler in matplotlib.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: cool_path
    type: File
    doc: Path to a COOL file or Cooler URI.
    inputBinding:
      position: 1
  - id: range
    type: string
    doc: The coordinates of the genomic region to display, in UCSC notation.
    inputBinding:
      position: 2
  - id: balanced
    type:
      - 'null'
      - boolean
    doc: Show the balanced contact matrix. If not provided, display the 
      unbalanced counts.
    inputBinding:
      position: 103
      prefix: --balanced
  - id: cmap
    type:
      - 'null'
      - string
    doc: The colormap used to display the contact matrix. See the full list at 
      http://matplotlib.org/examples/color/colormaps_reference.html
    inputBinding:
      position: 103
      prefix: --cmap
  - id: dpi
    type:
      - 'null'
      - int
    doc: The DPI of the figure, if saving to a file
    inputBinding:
      position: 103
      prefix: --dpi
  - id: field
    type:
      - 'null'
      - string
    doc: 'Pixel values to display.  [default: count]'
    inputBinding:
      position: 103
      prefix: --field
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force display very large matrices (>=10^8 pixels). Use at your own risk
      as it may cause performance issues.
    inputBinding:
      position: 103
      prefix: --force
  - id: range2
    type:
      - 'null'
      - string
    doc: The coordinates of a genomic region shown along the column dimension. 
      If omitted, the column range is the same as the row range. Use to display 
      asymmetric matrices or trans interactions.
    inputBinding:
      position: 103
      prefix: --range2
  - id: scale
    type:
      - 'null'
      - string
    doc: 'Scale transformation of the colormap: linear, log2 or log10. Default is
      log10.'
    inputBinding:
      position: 103
      prefix: --scale
  - id: zmax
    type:
      - 'null'
      - float
    doc: The maximal value of the color scale. Units must match those of the 
      colormap scale. To provide a negative value use a equal sign and quotes, 
      e.g. -zmax='-0.5'
    inputBinding:
      position: 103
      prefix: --zmax
  - id: zmin
    type:
      - 'null'
      - float
    doc: The minimal value of the color scale. Units must match those of the 
      colormap scale. To provide a negative value use a equal sign and quotes, 
      e.g. -zmin='-0.5'
    inputBinding:
      position: 103
      prefix: --zmin
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Save the image of the contact matrix to a file. If not specified, the 
      matrix is displayed in an interactive window. The figure format is deduced
      from the extension of the file, the supported formats are png, jpg, svg, 
      pdf, ps and eps.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
