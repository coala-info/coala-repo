cwlVersion: v1.2
class: CommandLineTool
baseCommand: md-cogent_get_seqs_from_list.py
label: md-cogent_get_seqs_from_list.py
doc: "Extract sequences from a list (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/Magdoll/Cogent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/md-cogent:8.0.0--pyh3252c3a_0
stdout: md-cogent_get_seqs_from_list.py.out
