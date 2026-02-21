cwlVersion: v1.2
class: CommandLineTool
baseCommand: clusterfunk
label: clusterfunk
doc: "A tool for manipulating and annotating phylogenetic trees (Note: The provided
  text contains only system error logs and no help documentation. No arguments could
  be extracted.)\n\nTool homepage: https://github.com/cov-ert/clusterfunk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
stdout: clusterfunk.out
