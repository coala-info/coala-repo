cwlVersion: v1.2
class: CommandLineTool
baseCommand: maskrc-svg.py
label: maskrc-svg_maskrc-svg.py
doc: "Mask recombination from ClonalFrameML/Gubbins output and draw SVG of recombinant
  regions\n\nTool homepage: https://github.com/kwongj/maskrc-svg"
inputs:
  - id: prefix
    type: string
    doc: prefix used for CFML/Gubbins input files (required)
    inputBinding:
      position: 1
  - id: aln
    type: File
    doc: multiFASTA alignment used as input for CFML (required)
    inputBinding:
      position: 102
      prefix: --aln
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: add consensus row of recombination hotspots
    inputBinding:
      position: 102
      prefix: --consensus
  - id: gubbins
    type:
      - 'null'
      - boolean
    doc: parse as Gubbins instead of ClonalFrameML
    inputBinding:
      position: 102
      prefix: --gubbins
  - id: regions
    type:
      - 'null'
      - File
    doc: output recombinant regions to file
    inputBinding:
      position: 102
      prefix: --regions
  - id: svgcolour
    type:
      - 'null'
      - string
    doc: specify colour of recombination regions in HEX format (default=black)
    inputBinding:
      position: 102
      prefix: --svgcolour
  - id: svgorder
    type:
      - 'null'
      - File
    doc: specify file containing list of taxa (1 per line) in desired order
    inputBinding:
      position: 102
      prefix: --svgorder
  - id: svgsize
    type:
      - 'null'
      - string
    doc: specify width and height of SVG in pixels (default="800x600")
    inputBinding:
      position: 102
      prefix: --svgsize
  - id: symbol
    type:
      - 'null'
      - string
    doc: symbol to use for masking (default="?")
    inputBinding:
      position: 102
      prefix: --symbol
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file for masked alignment (default="maskrc.aln")
    outputBinding:
      glob: $(inputs.out)
  - id: svg
    type:
      - 'null'
      - File
    doc: draw SVG output of recombinant regions and save as specified file
    outputBinding:
      glob: $(inputs.svg)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maskrc-svg:0.5--0
