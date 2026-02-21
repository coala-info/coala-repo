cwlVersion: v1.2
class: CommandLineTool
baseCommand: dashing
label: dashing_dashing_s128
doc: "Dashing is a tool for fast genomic distance estimation using HyperLogLog sketches.
  (Note: The provided text appears to be a system error log rather than help text,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_dashing_s128.out
