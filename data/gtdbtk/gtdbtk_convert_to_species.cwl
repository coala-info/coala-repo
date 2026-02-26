cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdbtk convert_to_species
label: gtdbtk_convert_to_species
doc: "Convert a tree to a species-resolved tree.\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: all_ranks
    type:
      - 'null'
      - boolean
    doc: "add all missing ranks to the leaf nodes if they are\npresent in the reference
      tree."
    default: false
    inputBinding:
      position: 101
      prefix: --all_ranks
  - id: custom_taxonomy_file
    type:
      - 'null'
      - File
    doc: "file indicating custom taxonomy strings for user\ngenomes, that should contain
      any genomes belonging to\nthe outgroup. Format:\nGENOME_ID<TAB>d__;p__;c__;o__;f__;g__;s__"
    inputBinding:
      position: 101
      prefix: --custom_taxonomy_file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_tree
    type: File
    doc: path to the unrooted tree in Newick format
    inputBinding:
      position: 101
      prefix: --input_tree
outputs:
  - id: output_tree
    type: File
    doc: path to output the tree
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
