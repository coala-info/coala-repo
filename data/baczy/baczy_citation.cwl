cwlVersion: v1.2
class: CommandLineTool
baseCommand: baczy_citation
label: baczy_citation
doc: "Please cite sphaehost in your paper using this article:\n\nTool homepage: https://github.com/npbhavya/baczy/"
inputs:
  - id: snakemake_doi
    type:
      - 'null'
      - string
    doc: https://doi.org/10.12688/f1000research.29032.1
    inputBinding:
      position: 101
      prefix: Snakemake
  - id: snaketool_doi
    type:
      - 'null'
      - string
    doc: https://doi.org/10.1371/journal.pcbi.1010705
    inputBinding:
      position: 101
      prefix: Snaketool
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baczy:1.0.3--pyhdfd78af_0
stdout: baczy_citation.out
