cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nw_prune]
label: newick_utils_nw_prune
doc: "Removes nodes by label from Newick trees and prints the modified trees. A parent
  left with one child is spliced out.\n\nTool homepage: http://cegg.unige.ch/newick_utils"
arguments:
  - position: 1
    valueFrom: |-
      ${ return inputs.labels_file ? "-f" : null; }
inputs:
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse - prune the nodes whose labels are NOT given. Inner nodes are not pruned.
    inputBinding:
      position: 2
      prefix: -v
  - id: newick_file
    type: File
    doc: File with Newick trees.
    inputBinding:
      position: 3
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Node labels to prune (given on the command line).
    inputBinding:
      position: 4
  - id: labels_file
    type:
      - 'null'
      - File
    doc: File with one label per line (no leading or trailing whitespace), used instead of labels (adds -f).
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Modified trees.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newick_utils:1.6--hd747bf3_9
stdout: newick_utils_nw_prune.out
