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
  - id: prefix_files
    type:
      type: array
      items: File
    doc: The ClonalFrameML (PREFIX.labelled_tree.newick, PREFIX.importation_status.txt)
      or Gubbins (PREFIX.final_tree.tre, PREFIX.recombination_predictions.gff) files
      named by the prefix, staged in the working directory.
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
      - string
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
  - id: out_path
    type:
      - 'null'
      - string
    doc: output file for masked alignment (default="maskrc.aln")
    inputBinding:
      position: 103
      prefix: --out
  - id: svg_path
    type:
      - 'null'
      - string
    doc: draw SVG output of recombinant regions and save as specified file
    inputBinding:
      position: 104
      prefix: --svg
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file for masked alignment (default="maskrc.aln")
    outputBinding:
      glob: $(inputs.out_path)
  - id: svg
    type:
      - 'null'
      - File
    doc: draw SVG output of recombinant regions and save as specified file
    outputBinding:
      glob: $(inputs.svg_path)
  - id: regions_out
    type:
      - 'null'
      - File
    doc: output recombinant regions to file
    outputBinding:
      glob: $(inputs.regions)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.prefix_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maskrc-svg:0.5--0
