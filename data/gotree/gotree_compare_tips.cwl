cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - compare
  - tips
label: gotree_compare_tips
doc: "Print diff between tip names of two trees or between a tree and a list of tips.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: tip_file
    type:
      - 'null'
      - File
    doc: "Tip File (Optional)"
    inputBinding:
      position: 101
      prefix: --tipfile
  - id: compared_tree
    type:
      - 'null'
      - File
    doc: "Compared trees input file"
    inputBinding:
      position: 101
      prefix: --compared
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: reference_tree
    type: File
    doc: "Reference tree input file"
    inputBinding:
      position: 101
      prefix: --reftree
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_compare_tips.out
