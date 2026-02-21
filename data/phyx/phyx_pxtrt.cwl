cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxtrt
label: phyx_pxtrt
doc: "This will trace a big tree given a taxon list and produce newick. Data can be
  read from a file or STDIN.\n\nTool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: complement
    type:
      - 'null'
      - boolean
    doc: take the complement (i.e. remove any taxa not in list)
    inputBinding:
      position: 101
      prefix: --comp
  - id: names
    type:
      - 'null'
      - string
    doc: names sep by commas (NO SPACES!)
    inputBinding:
      position: 101
      prefix: --names
  - id: names_file
    type:
      - 'null'
      - File
    doc: names in a file (each on a line)
    inputBinding:
      position: 101
      prefix: --namesf
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress warnings of missing tips
    inputBinding:
      position: 101
      prefix: --silent
  - id: tree_file
    type:
      - 'null'
      - File
    doc: input tree file, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --treef
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output tree file, STOUT otherwise
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
