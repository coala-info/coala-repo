cwlVersion: v1.2
class: CommandLineTool
baseCommand: md-cogent_run_preCluster.py
label: md-cogent_run_preCluster.py
doc: "A tool for running pre-clustering in the MD-Cogent pipeline. (Note: The provided
  input text contained container runtime error messages rather than the tool's help
  documentation, so no arguments could be extracted.)\n\nTool homepage: https://github.com/Magdoll/Cogent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/md-cogent:8.0.0--pyh3252c3a_0
stdout: md-cogent_run_preCluster.py.out
