cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp_colour
label: treesapp_colour
doc: "Generates colour style and strip files for visualizing a reference package's
  phylogeny in iTOL based on taxonomic or phenotypic data.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: refpkg_path
    type:
      type: array
      items: File
    doc: Path to the reference package pickle (.pkl) file.
    inputBinding:
      position: 1
  - id: attribute
    type:
      - 'null'
      - string
    doc: The reference package attribute to colour by. Either 'taxonomy' or a 
      reference package's layering annotation name.
    default: taxonomy
    inputBinding:
      position: 102
      prefix: --attribute
  - id: min_proportion
    type:
      - 'null'
      - float
    doc: Minimum proportion of sequences a group contains to be coloured
    default: 0
    inputBinding:
      position: 102
      prefix: --min_proportion
  - id: no_polyphyletic
    type:
      - 'null'
      - boolean
    doc: Flag forcing the omission of all polyphyletic taxa from the colours 
      file.
    inputBinding:
      position: 102
      prefix: --no_polyphyletic
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites previously written output files and directories
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: palette
    type:
      - 'null'
      - string
    doc: The Seaborn colour palette to use
    default: BrBG
    inputBinding:
      position: 102
      prefix: --palette
  - id: rank_level
    type:
      - 'null'
      - string
    doc: The rank to generate unique colours for
    default: order
    inputBinding:
      position: 102
      prefix: --rank_level
  - id: taxa_filter
    type:
      - 'null'
      - string
    doc: Keywords for excluding specific taxa from the colour palette.
    default: no filter
    inputBinding:
      position: 102
      prefix: --filter
  - id: taxa_set_operation
    type:
      - 'null'
      - string
    doc: When multiple reference packages are provided, should the union (u) or 
      intersection (i) of all labelled taxa (post-filtering) be coloured?
    default: u
    inputBinding:
      position: 102
      prefix: --taxa_set_operation
  - id: unknown_colour
    type:
      - 'null'
      - string
    doc: Colour of the 'Unknown' category.
    default: None
    inputBinding:
      position: 102
      prefix: --unknown_colour
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints a more verbose runtime log
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory to write the output files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
