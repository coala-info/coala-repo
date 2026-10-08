cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtdbtk
  - infer_ranks
label: gtdbtk_infer_ranks
doc: "Root the input tree at the specified ingroup taxon and output the rooted tree.\n\
  \nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: gtdbtk_data
    type: Directory
    doc: GTDB-Tk reference data directory (sets GTDBTK_DATA_PATH)
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
    inputBinding:
      position: 101
      prefix: --debug
  - id: ingroup_taxon
    type: string
    doc: labelled ingroup taxon to use as root for establishing RED values 
      (e.g., c__Bacilli or f__Lactobacillaceae
    inputBinding:
      position: 101
      prefix: --ingroup_taxon
  - id: input_tree
    type: File
    doc: rooted input tree with labelled ingroup taxon
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
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: GTDBTK_DATA_PATH
        envValue: $(inputs.gtdbtk_data.path)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
