cwlVersion: v1.2
class: CommandLineTool
baseCommand: md-cogent_process_kmer_to_graph.py
label: md-cogent_process_kmer_to_graph.py
doc: "Process k-mers to graph. (Note: The provided help text contains container runtime
  error messages and does not include tool-specific usage or argument information.)\n
  \nTool homepage: https://github.com/Magdoll/Cogent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/md-cogent:8.0.0--pyh3252c3a_0
stdout: md-cogent_process_kmer_to_graph.py.out
