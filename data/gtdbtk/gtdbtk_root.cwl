cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdbtk_root
label: gtdbtk_root
doc: "Root a tree using a specified outgroup taxon.\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: custom_taxonomy_file
    type:
      - 'null'
      - File
    doc: "file indicating custom taxonomy strings for user genomes, that should contain
      any genomes belonging to the outgroup. Format:\n                        GENOME_ID<TAB>d__;p__;c__;o__;f__;g__;s__"
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
  - id: gtdbtk_classification_file
    type:
      - 'null'
      - File
    doc: file with GTDB-Tk classifications produced by the `classify` command
    inputBinding:
      position: 101
      prefix: --gtdbtk_classification_file
  - id: input_tree
    type: File
    doc: path to the unrooted tree in Newick format
    inputBinding:
      position: 101
      prefix: --input_tree
  - id: outgroup_taxon
    type: string
    doc: taxon to use as outgroup (e.g., p__Patescibacteriota or 
      p__Altiarchaeota)
    inputBinding:
      position: 101
      prefix: --outgroup_taxon
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify alternative directory for temporary files
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: output_tree
    type: File
    doc: path to output the tree
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
