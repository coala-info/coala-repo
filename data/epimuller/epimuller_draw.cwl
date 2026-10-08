cwlVersion: v1.2
class: CommandLineTool
baseCommand: epimuller-draw
label: epimuller_draw
doc: "Draws Muller plots from the clade hierarchy and abundance tables made by epimuller-define.\n\nTool homepage: https://github.com/jennifer-bio/epimuller"
inputs:
  - id: parent_hierarchy_name
    type: File
    doc: "csv output from epimuller-define with child parent col"
    inputBinding:
      position: 101
      prefix: --parentHierarchy_name
  - id: abundance_name
    type: File
    doc: "csv output from epimuller-define with abundances of clades"
    inputBinding:
      position: 101
      prefix: --abundance_name
  - id: cases_name
    type:
      - 'null'
      - File
    doc: "file with cases - formated with 'date' in ISO format and 'confirmed_rolling' cases, in tsv format"
    inputBinding:
      position: 101
      prefix: --cases_name
  - id: avg_window
    type:
      - 'null'
      - int
    doc: "width of rolling mean window in terms of --timeWindow's (recomend using with small --timeWindow)"
    inputBinding:
      position: 101
      prefix: --avgWindow
  - id: out_folder
    type: string
    doc: "output folder"
    inputBinding:
      position: 101
      prefix: --outFolder
  - id: mintime
    type:
      - 'null'
      - int
    doc: "minimum time point to start plotting"
    inputBinding:
      position: 101
      prefix: --MINTIME
  - id: mintotalcount
    type:
      - 'null'
      - int
    doc: "minimum total count for group to be included"
    inputBinding:
      position: 101
      prefix: --MINTOTALCOUNT
  - id: xlabel
    type:
      - 'null'
      - string
    doc: "Format of x axis label: date, time or bimonthly"
    inputBinding:
      position: 101
      prefix: --xlabel
  - id: label_position
    type:
      - 'null'
      - string
    doc: "choose position of clade labels: Right, Max, Start or End"
    inputBinding:
      position: 101
      prefix: --labelPosition
  - id: width
    type:
      - 'null'
      - int
    doc: "WIDTH of page (px)"
    inputBinding:
      position: 101
      prefix: --WIDTH
  - id: height
    type:
      - 'null'
      - int
    doc: "HEIGHT of page (px)"
    inputBinding:
      position: 101
      prefix: --HEIGHT
  - id: legend_width
    type:
      - 'null'
      - int
    doc: "LEGENDWIDTH to the right of plotting area (px)"
    inputBinding:
      position: 101
      prefix: --LEGENDWIDTH
  - id: label_shift
    type:
      - 'null'
      - int
    doc: "nudge label over by LABELSHIFT (px)"
    inputBinding:
      position: 101
      prefix: --LABELSHIFT
  - id: margin
    type:
      - 'null'
      - int
    doc: "MARGIN around all sides of plotting area (px)"
    inputBinding:
      position: 101
      prefix: --MARGIN
  - id: font_size
    type:
      - 'null'
      - int
    doc: "FONTSIZE"
    inputBinding:
      position: 101
      prefix: --FONTSIZE
outputs:
  - id: out_folder_dir
    type: Directory
    doc: Folder with the plots
    outputBinding:
      glob: $(inputs.out_folder)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epimuller:0.0.8--pyhdfd78af_0
stdout: epimuller_draw.out
