cwlVersion: v1.2
class: CommandLineTool
baseCommand: minigraph
label: minigraph_gfatools
doc: "The provided text is an error log indicating a failure to pull or run the container
  (no space left on device) and does not contain help information or argument definitions.\n
  \nTool homepage: https://github.com/lh3/minigraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minigraph:0.21--h577a1d6_3
stdout: minigraph_gfatools.out
