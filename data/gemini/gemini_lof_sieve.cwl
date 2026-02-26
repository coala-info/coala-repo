cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemini
  - lof_sieve
label: gemini_lof_sieve
doc: "Queries the database for LOF variants.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_lof_sieve.out
