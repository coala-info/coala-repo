cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - prune
label: gotree_prune
doc: "This tool removes tips of the input reference tree that :.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: compared_tree
    type:
      - 'null'
      - File
    doc: "Input compared tree"
    inputBinding:
      position: 101
      prefix: --comp
  - id: diversity
    type:
      - 'null'
      - boolean
    doc: "If the random pruning takes into account diversity (only with --random)"
    inputBinding:
      position: 101
      prefix: --diversity
  - id: output_file_path
    type: string
    doc: "Output tree"
    inputBinding:
      position: 101
      prefix: --output
  - id: random
    type:
      - 'null'
      - int
    doc: "Number of tips to randomly sample"
    inputBinding:
      position: 101
      prefix: --random
  - id: reference_tree
    type: File
    doc: "Input reference tree"
    inputBinding:
      position: 101
      prefix: --ref
  - id: revert
    type:
      - 'null'
      - boolean
    doc: "If true, then revert the behavior: will keep only species given in the command line, or keep only the species that are specific to the input tree, or keep only randomly selected taxa"
    inputBinding:
      position: 101
      prefix: --revert
  - id: tip_file
    type:
      - 'null'
      - File
    doc: "Tip file"
    inputBinding:
      position: 101
      prefix: --tipfile
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: tip_names
    type:
      - 'null'
      - type: array
        items: string
    doc: "Tip names given as arguments (alternative to the tip file)"
    inputBinding:
      position: 200
outputs:
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
