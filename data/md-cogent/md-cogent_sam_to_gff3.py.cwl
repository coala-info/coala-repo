cwlVersion: v1.2
class: CommandLineTool
baseCommand: md-cogent_sam_to_gff3.py
label: md-cogent_sam_to_gff3.py
doc: "The provided text contains system error messages related to a container runtime
  failure and does not include the help documentation for the tool. No arguments could
  be extracted.\n\nTool homepage: https://github.com/Magdoll/Cogent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/md-cogent:8.0.0--pyh3252c3a_0
stdout: md-cogent_sam_to_gff3.py.out
