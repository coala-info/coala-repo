cwlVersion: v1.2
class: CommandLineTool
baseCommand: nw_prune
label: newick_utils_nw_prune
doc: "Prune nodes from a Newick tree. (Note: The provided help text contained only
  system error messages; arguments are derived from standard tool documentation for
  nw_prune).\n\nTool homepage: http://cegg.unige.ch/newick_utils"
inputs:
  - id: newick_file
    type: File
    doc: Input Newick tree file
    inputBinding:
      position: 1
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Labels of nodes to prune
    inputBinding:
      position: 2
  - id: label_file
    type:
      - 'null'
      - File
    doc: Read labels to be pruned from a file
    inputBinding:
      position: 103
      prefix: -f
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newick_utils:1.6--hd747bf3_9
stdout: newick_utils_nw_prune.out
