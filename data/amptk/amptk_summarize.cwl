cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amptk
  - summarize
label: amptk_summarize
doc: "Traverse the taxonomy information of an OTU table and create an OTU-like table
  for each taxonomy level (Kingdom, Phylum, Class, ...). Optionally create a stacked
  bar graph for each level.\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: table
    type: File
    doc: OTU table containing taxonomy information (e.g. <base>.otu_table.taxonomy.txt
      from amptk taxonomy)
    inputBinding:
      position: 101
      prefix: --table
  - id: counts
    type:
      - 'null'
      - string
    doc: 'Method to count taxa: binary or actual. Default: binary'
    inputBinding:
      position: 101
      prefix: --counts
  - id: graphs
    type:
      - 'null'
      - boolean
    doc: Create stacked bar graphs.
    inputBinding:
      position: 101
      prefix: --graphs
  - id: format
    type:
      - 'null'
      - string
    doc: 'Image output format: eps, svg, png or pdf. Default: eps'
    inputBinding:
      position: 101
      prefix: --format
  - id: percent
    type:
      - 'null'
      - boolean
    doc: 'Convert numbers to percent for graphs. Default: off'
    inputBinding:
      position: 101
      prefix: --percent
  - id: font_size
    type:
      - 'null'
      - int
    doc: 'Font size for X-axis sample labels. Default: 8'
    inputBinding:
      position: 101
      prefix: --font_size
  - id: out
    type: string
    doc: Base name for output files
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: out_files
    type:
      type: array
      items: File
    doc: One table (.csv) per taxonomy level, plus graphs when --graphs is set
    outputBinding:
      glob: $(inputs.out).*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
