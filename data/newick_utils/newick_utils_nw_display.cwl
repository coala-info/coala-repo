cwlVersion: v1.2
class: CommandLineTool
baseCommand: nw_display
label: newick_utils_nw_display
doc: "A utility from the Newick Utilities package used to display or render phylogenetic
  trees. Note: The provided help text contains a fatal system error regarding container
  execution and does not list specific command-line arguments.\n\nTool homepage: http://cegg.unige.ch/newick_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newick_utils:1.6--hd747bf3_9
stdout: newick_utils_nw_display.out
