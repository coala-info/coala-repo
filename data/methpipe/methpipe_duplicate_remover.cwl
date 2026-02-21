cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - duplicate-remover
label: methpipe_duplicate_remover
doc: "The provided text contains container runtime error messages and does not include
  the help documentation for the tool. Based on the tool name hint, this tool is part
  of the Methpipe suite and is used to remove PCR duplicates from mapped bisulfite
  sequencing reads.\n\nTool homepage: https://github.com/smithlabcode/methpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
stdout: methpipe_duplicate_remover.out
