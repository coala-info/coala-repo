cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mapview
label: mummer_mapview
doc: "Display sequence alignments as provided by MUMmer, NUCmer, PROmer or Mgaps. mapview takes the output of show-coords and converts it to a FIG, PDF or PS file for visual analysis, and can break the output into multiple files.\n\nTool homepage: https://github.com/mummer4/mummer"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: maxdist
    type:
      - 'null'
      - int
    doc: "Set the maximum base-pair distance between linked matches (default 50000)"
    inputBinding:
      position: 1
      prefix: "-d"
  - id: format
    type:
      - 'null'
      - string
    doc: "Set the output format to pdf, ps or fig (default fig)"
    inputBinding:
      position: 1
      prefix: "-f"
  - id: mag
    type:
      - 'null'
      - float
    doc: "Set the magnification at which the figure is rendered, this is an option for fig2dev which is used to generate the PDF and PS files (default 1.0)"
    inputBinding:
      position: 1
      prefix: "-m"
  - id: num
    type:
      - 'null'
      - int
    doc: "Set the number of output files used to partition the output, this is to avoid generating files that are too large to display (default 10)"
    inputBinding:
      position: 1
      prefix: "-n"
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Set the output file prefix (default PROMER_graph or NUCMER_graph)"
    inputBinding:
      position: 1
      prefix: "-p"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging of the processed files"
    inputBinding:
      position: 1
      prefix: "-v"
  - id: x1
    type:
      - 'null'
      - int
    doc: "Set the lower coordinate bound of the display"
    inputBinding:
      position: 1
      prefix: "-x1"
  - id: x2
    type:
      - 'null'
      - int
    doc: "Set the upper coordinate bound of the display"
    inputBinding:
      position: 1
      prefix: "-x2"
  - id: ref
    type:
      - 'null'
      - string
    doc: "If the input file is provided by mgaps, set the reference sequence ID (as it appears in the first column of the UTR/CDS coords file)"
    inputBinding:
      position: 1
      prefix: "-g"
  - id: show_query_names
    type:
      - 'null'
      - boolean
    doc: "Display the name of query sequences"
    inputBinding:
      position: 1
      prefix: "-I"
  - id: show_gene_names
    type:
      - 'null'
      - boolean
    doc: "Display the name of reference genes"
    inputBinding:
      position: 1
      prefix: "-Ir"
  - id: coords_file
    type: File
    doc: "The output of show-coords -rl[k] or mgaps"
    inputBinding:
      position: 100
  - id: utr_coords
    type:
      - 'null'
      - File
    doc: "UTR coordinate file in GFF format"
    inputBinding:
      position: 101
  - id: cds_coords
    type:
      - 'null'
      - File
    doc: "CDS coordinate file in GFF format"
    inputBinding:
      position: 102
outputs:
  - id: figures
    type: File[]
    doc: "Alignment figures (FIG, PDF or PS files, split into several parts)"
    outputBinding:
      glob: "$(inputs.prefix ? inputs.prefix + '*' : '*_graph*')"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stderr: mummer_mapview.log
