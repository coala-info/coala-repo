cwlVersion: v1.2
class: CommandLineTool
baseCommand: recentrifuge_rgf
label: recentrifuge_rgf
doc: "Recentrifuge: robust comparative analysis and contamination removal for metagenomics
  (Note: The provided text contains system error logs rather than help documentation,
  so no arguments could be extracted).\n\nTool homepage: https://github.com/khyox/recentrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.0.0--pyhdfd78af_0
stdout: recentrifuge_rgf.out
