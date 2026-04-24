cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdbtk infer_ranks
label: gtdbtk_infer_ranks
doc: "Root the input tree at the specified ingroup taxon and output the rooted tree.\n\
  \nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
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
      - Directory
    doc: specify alternative directory for temporary files
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
