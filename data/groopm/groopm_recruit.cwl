cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm recruit
label: groopm_recruit
doc: "Recruit more contigs into existing bins\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: name of the database to open
    inputBinding:
      position: 1
  - id: cutoff
    type:
      - 'null'
      - int
    doc: cutoff contig size
    default: 500
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite existing db file without prompting
    default: false
    inputBinding:
      position: 102
      prefix: --force
  - id: inclusivity
    type:
      - 'null'
      - float
    doc: make recruitment more or less inclusive
    default: 2.5
    inputBinding:
      position: 102
      prefix: --inclusivity
  - id: step
    type:
      - 'null'
      - int
    doc: step size for iterative recruitment
    default: 200
    inputBinding:
      position: 102
      prefix: --step
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_recruit.out
