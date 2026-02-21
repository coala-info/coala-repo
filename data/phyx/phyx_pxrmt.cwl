cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxrmt
label: phyx_pxrmt
doc: "Remove tree tips by label. This will take a newick- or nexus-formatted tree
  from a file or STDIN. Output is written in newick format.\n\nTool homepage: https://github.com/FePhyFoFum/phyx"
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
  - id: regex
    type:
      - 'null'
      - string
    doc: match tip labels by a regular expression
    inputBinding:
      position: 101
      prefix: --regex
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
