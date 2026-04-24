cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - rename
label: gotree_rename
doc: "Rename nodes/tips of the input tree.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: add_quotes
    type:
      - 'null'
      - boolean
    doc: Add quotes arround tip/node names
    inputBinding:
      position: 101
      prefix: --add-quotes
  - id: auto
    type:
      - 'null'
      - boolean
    doc: Renames automatically tips with auto generated id of length 10.
    inputBinding:
      position: 101
      prefix: --auto
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    inputBinding:
      position: 101
      prefix: --format
  - id: input_tree
    type:
      - 'null'
      - File
    doc: Input tree
    inputBinding:
      position: 101
      prefix: --input
  - id: internal
    type:
      - 'null'
      - boolean
    doc: Internal nodes are taken into account
    inputBinding:
      position: 101
      prefix: --internal
  - id: length
    type:
      - 'null'
      - int
    doc: Length of automatically generated id. Only with --auto
    inputBinding:
      position: 101
      prefix: --length
  - id: map_file
    type:
      - 'null'
      - File
    doc: Tip name map file
    inputBinding:
      position: 101
      prefix: --map
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    inputBinding:
      position: 101
      prefix: --seed
  - id: regexp
    type:
      - 'null'
      - string
    doc: Regexp to get matching tip/node names
    inputBinding:
      position: 101
      prefix: --regexp
  - id: replace
    type:
      - 'null'
      - string
    doc: String replacement to the given regexp
    inputBinding:
      position: 101
      prefix: --replace
  - id: revert
    type:
      - 'null'
      - boolean
    doc: Revert orientation of map file
    inputBinding:
      position: 101
      prefix: --revert
  - id: rm_quotes
    type:
      - 'null'
      - boolean
    doc: Remove quotes arround tip/node names (priority over --rm-quotes)
    inputBinding:
      position: 101
      prefix: --rm-quotes
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    inputBinding:
      position: 101
      prefix: --threads
  - id: tips
    type:
      - 'null'
      - boolean
    doc: Tips are taken into account (--tips=false to cancel)
    inputBinding:
      position: 101
      prefix: --tips
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Renamed tree output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
