cwlVersion: v1.2
class: CommandLineTool
baseCommand: nw_condense
label: newick_utils_nw_condense
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: http://cegg.unige.ch/newick_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newick_utils:1.6--hd747bf3_9
stdout: newick_utils_nw_condense.out
