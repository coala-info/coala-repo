cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm_refine
label: groopm_refine
doc: "Merge similar bins and split chimeric ones\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: name of the database to open
    inputBinding:
      position: 1
  - id: auto
    type:
      - 'null'
      - boolean
    doc: automatically refine bins
    inputBinding:
      position: 102
      prefix: --auto
  - id: no_transform
    type:
      - 'null'
      - boolean
    doc: skip data transformation (3 stoits only)
    inputBinding:
      position: 102
      prefix: --no_transform
  - id: plot
    type:
      - 'null'
      - boolean
    doc: create plots of bins after refinement
    inputBinding:
      position: 102
      prefix: --plot
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_refine.out
