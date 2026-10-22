cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxknife
label: taxator-tk_taxknife
doc: "Look up, traverse or write the NCBI taxonomy for taxonomic ids found in a column of standard input (modes annotate, traverse and tree).

Tool homepage: https://github.com/fungs/taxator-tk"
inputs:
  - id: taxonomy_dir
    type: Directory
    doc: "NCBI taxonomy dump directory (nodes.dmp, names.dmp, merged.dmp); given to the tool by the environment variable TAXATORTK_TAXONOMY_NCBI"
  - id: input_table
    type: File
    doc: "Tab-separated input read from standard input; the taxonomic ids are in the column given by field"
  - id: mode
    type:
      - 'null'
      - string
    doc: "choose mode: traverse (follow nodes upwards in taxonomy), annotate (look up meta-information attached to nodes, e.g. names) or tree (write a (sub)tree)"
    inputBinding:
      position: 101
      prefix: --mode
  - id: field
    type:
      - 'null'
      - int
    doc: "input column"
    inputBinding:
      position: 101
      prefix: --field
  - id: keep_not_rank
    type:
      - 'null'
      - boolean
    doc: "traverse mode: unmappable taxids remain (otherwise mapped to root)"
    inputBinding:
      position: 101
      prefix: --keep-not-rank
  - id: keep_not_taxid
    type:
      - 'null'
      - boolean
    doc: "traverse mode: unknown taxonomic IDs are kept (otherwise skipped)"
    inputBinding:
      position: 101
      prefix: --keep-not-taxid
  - id: set_invalid_traverse
    type:
      - 'null'
      - string
    doc: "traverse mode: replace unknown taxids by this given value"
    inputBinding:
      position: 101
      prefix: --set-invalid-traverse
  - id: traverse_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: "traverse mode: traverse taxonomy up to one of these ranks (space separated list)"
    inputBinding:
      position: 101
      prefix: --traverse-ranks
  - id: allnodes
    type:
      - 'null'
      - boolean
    doc: "annotate mode: if set, all nodes will be used, not only at selected ranks"
    inputBinding:
      position: 101
      prefix: --allnodes
  - id: set_invalid_annotate
    type:
      - 'null'
      - string
    doc: "annotate mode: replace all taxids that are invalid by this given value"
    inputBinding:
      position: 101
      prefix: --set-invalid-annotate
  - id: show
    type:
      - 'null'
      - string
    doc: "annotate mode: either 'name', 'rank', 'path' or 'taxid-path'"
    inputBinding:
      position: 101
      prefix: --show
  - id: name_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: "annotate mode: select ranks to be considered; if not set, default ranks will be used"
    inputBinding:
      position: 101
      prefix: --name-ranks
  - id: tree_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: "tree mode: consider these taxonomic ranks (ordered space separated list from low to high, e.g. species family phylum)"
    inputBinding:
      position: 101
      prefix: --tree-ranks
  - id: outfile
    type:
      - 'null'
      - string
    doc: "tree mode: name of newick file to be written (default tree.newick)"
    inputBinding:
      position: 101
      prefix: --outfile
  - id: fill_intermediate
    type:
      - 'null'
      - boolean
    doc: "tree mode: fill in dummy intermediate nodes if ranks are missing"
    inputBinding:
      position: 101
      prefix: --fill-intermediate
  - id: names
    type:
      - 'null'
      - boolean
    doc: "tree mode: show scientific names in tree (no character restrictions)"
    inputBinding:
      position: 101
      prefix: --names
outputs:
  - id: stdout
    type: stdout
    doc: "Annotated or traversed table"
  - id: tree_file
    type: ['null', File]
    doc: "Newick tree written in tree mode"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: TAXATORTK_TAXONOMY_NCBI
        envValue: $(inputs.taxonomy_dir.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxator-tk:1.3.3e--0
stdout: taxator-tk_taxknife.out
stdin: $(inputs.input_table.path)
