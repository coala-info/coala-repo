cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_set.seed
doc: "mothur v.1.48.5\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Setting random seed
    inputBinding:
      position: 101
      prefix: --random-seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
stdout: mothur_set.seed.out
