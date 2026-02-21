cwlVersion: v1.2
class: CommandLineTool
baseCommand: nw_trim
label: newick_utils_nw_trim
doc: "A tool from the Newick Utilities package (nw_trim). Note: The provided help
  text contains only system error messages regarding container execution and disk
  space, so no specific arguments could be extracted.\n\nTool homepage: http://cegg.unige.ch/newick_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newick_utils:1.6--hd747bf3_9
stdout: newick_utils_nw_trim.out
