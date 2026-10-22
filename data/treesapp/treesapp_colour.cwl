cwlVersion: v1.2
class: CommandLineTool
baseCommand: [treesapp, colour]
label: treesapp_colour
doc: "Generates colour style and strip files for visualizing a reference package's phylogeny in iTOL based on taxonomic or phenotypic data.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: refpkg_path
    type:
      type: array
      items: File
    doc: "Path to the reference package pickle (.pkl) file(s)."
    inputBinding:
      position: 101
      prefix: --refpkg_path
  - id: attribute
    type:
      - 'null'
      - string
    doc: "The reference package attribute to colour by. Either 'taxonomy' or a layering annotation name. [ DEFAULT = 'taxonomy' ]"
    inputBinding:
      position: 101
      prefix: --attribute
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Path to the output directory to write the output files. [ DEFAULT = ./ ]"
    default: output
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: rank_level
    type:
      - 'null'
      - string
    doc: "The rank to generate unique colours for: domain, phylum, class, order, family, genus or species. [ DEFAULT = 'order' ]"
    inputBinding:
      position: 101
      prefix: --rank_level
  - id: palette
    type:
      - 'null'
      - string
    doc: "The Seaborn colour palette to use [ DEFAULT = BrBG ]"
    inputBinding:
      position: 101
      prefix: --palette
  - id: unknown_colour
    type:
      - 'null'
      - string
    doc: "Colour of the 'Unknown' category."
    inputBinding:
      position: 101
      prefix: --unknown_colour
  - id: min_proportion
    type:
      - 'null'
      - float
    doc: "Minimum proportion of sequences a group contains to be coloured [ DEFAULT = 0 ]"
    inputBinding:
      position: 101
      prefix: --min_proportion
  - id: taxa_filter
    type:
      - 'null'
      - string
    doc: "Keywords for excluding specific taxa from the colour palette. [ DEFAULT is no filter ]"
    inputBinding:
      position: 101
      prefix: --filter
  - id: taxa_set_operation
    type:
      - 'null'
      - string
    doc: "With several reference packages, colour the union (u) or intersection (i) of labelled taxa. [ DEFAULT = u ]"
    inputBinding:
      position: 101
      prefix: --taxa_set_operation
  - id: no_polyphyletic
    type:
      - 'null'
      - boolean
    doc: "Omit all polyphyletic taxa from the colours file."
    inputBinding:
      position: 101
      prefix: --no_polyphyletic
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrites previously written output files and directories"
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Prints a more verbose runtime log"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Directory with iTOL colour style and strip files"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
