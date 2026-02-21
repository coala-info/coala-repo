cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakesee
label: snakesee
doc: "A tool for visualizing Snakemake workflows (Note: The provided text contains
  container build logs rather than CLI help documentation; no arguments could be extracted
  from the input).\n\nTool homepage: https://github.com/nh13/snakesee"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0
stdout: snakesee.out
