cwlVersion: v1.2
class: CommandLineTool
baseCommand: gunc
label: gunc
doc: "GUNC (Genome Unclutterer) is a tool for detection of chimerism and contamination
  in prokaryotic genomes. (Note: The provided text contains container runtime error
  messages rather than tool help text; no arguments could be extracted from the input).\n
  \nTool homepage: https://github.com/grp-bork/gunc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
stdout: gunc.out
