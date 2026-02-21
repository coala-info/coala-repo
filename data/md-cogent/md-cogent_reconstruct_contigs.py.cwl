cwlVersion: v1.2
class: CommandLineTool
baseCommand: md-cogent_reconstruct_contigs.py
label: md-cogent_reconstruct_contigs.py
doc: "Reconstruct contigs using the Cogent toolset.\n\nTool homepage: https://github.com/Magdoll/Cogent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/md-cogent:8.0.0--pyh3252c3a_0
stdout: md-cogent_reconstruct_contigs.py.out
