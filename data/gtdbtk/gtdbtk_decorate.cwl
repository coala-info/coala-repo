cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtdbtk
  - decorate
label: gtdbtk_decorate
doc: "Decorate a tree with GTDB-Tk classifications and custom taxonomy.\n\nTool homepage:
  http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: gtdbtk_data
    type: Directory
    doc: GTDB-Tk reference data directory (sets GTDBTK_DATA_PATH)
  - id: custom_taxonomy_file
    type:
      - 'null'
      - File
    doc: 'file indicating custom taxonomy strings for user genomes, that should contain
      any genomes belonging to the outgroup. Format: GENOME_ID<TAB>d__;p__;c__;o__;f__;g__;s__'
    inputBinding:
      position: 101
      prefix: --custom_taxonomy_file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
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
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: specify alternative directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: output_tree_path
    type: string
    inputBinding:
      position: 102
      prefix: --output_tree
outputs:
  - id: output_tree
    type: File
    doc: path to output the tree
    outputBinding:
      glob: $(inputs.output_tree_path)
  - id: output_table
    type: File
    doc: table of taxon statistics written beside the output tree
    outputBinding:
      glob: $(inputs.output_tree_path)-table
  - id: output_taxonomy
    type: File
    doc: inferred taxonomy for each genome written beside the output tree
    outputBinding:
      glob: $(inputs.output_tree_path)-taxonomy
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: GTDBTK_DATA_PATH
        envValue: $(inputs.gtdbtk_data.path)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
