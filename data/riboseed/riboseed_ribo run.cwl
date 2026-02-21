cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribo
  - run
label: riboseed_ribo run
doc: "riboSeed: leveraging the entropy of ribosomal RNA genes for assembly and polishing\n
  \nTool homepage: https://github.com/nickp60/riboSeed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo run.out
