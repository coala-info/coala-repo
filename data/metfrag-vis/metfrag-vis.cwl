cwlVersion: v1.2
class: CommandLineTool
baseCommand: metfrag-vis
label: metfrag-vis
doc: "MetFrag visualization tool (Note: The provided text contains system error messages
  and does not include usage instructions or argument definitions).\n\nTool homepage:
  http://c-ruttkies.github.io/MetFrag/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metfrag-vis:phenomenal-v0.4.1_cv0.5.31
stdout: metfrag-vis.out
