cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgap2 post
label: pgap2_post
doc: "Performs post-processing analysis on pangenome data.\n\nTool homepage: https://github.com/bucongfan/PGAP2"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available options: stat, profile, singletree, baps,
      tajimas_d'
    inputBinding:
      position: 1
  - id: baps
    type:
      - 'null'
      - boolean
    doc: Workflow for bayesian analysis of population structure
    inputBinding:
      position: 102
  - id: profile
    type:
      - 'null'
      - boolean
    doc: To generate the pangenome profile using PAV matrix, it is the subset of
      [stat] module
    inputBinding:
      position: 102
  - id: singletree
    type:
      - 'null'
      - boolean
    doc: Workflow for bayesian analysis of population structure
    inputBinding:
      position: 102
  - id: stat
    type:
      - 'null'
      - boolean
    doc: Statistical analysis
    inputBinding:
      position: 102
  - id: tajimas_d
    type:
      - 'null'
      - boolean
    doc: Workflow for Tajima's D test
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
stdout: pgap2_post.out
