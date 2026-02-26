cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgi heatmap
label: rgi_rgi heatmap
doc: "Creates a heatmap when given multiple RGI results.\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: category
    type:
      - 'null'
      - string
    doc: The option to organize resistance genes based on a category.
    inputBinding:
      position: 101
      prefix: --category
  - id: cluster
    type:
      - 'null'
      - string
    doc: Option to use SciPy's hiearchical clustering algorithm to cluster rows 
      (AMR genes) or columns (samples).
    inputBinding:
      position: 101
      prefix: --cluster
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: display
    type:
      - 'null'
      - string
    doc: Specify display options for categories (deafult=plain).
    default: plain
    inputBinding:
      position: 101
      prefix: --display
  - id: frequency
    type:
      - 'null'
      - boolean
    doc: Represent samples based on resistance profile.
    inputBinding:
      position: 101
      prefix: --frequency
  - id: input
    type: Directory
    doc: Directory containing the RGI .json files (REQUIRED)
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Name for the output EPS and PNG files.\nThe number of files run will automatically\
      \ \nbe appended to the end of the file name."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
