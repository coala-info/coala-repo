cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin_info
label: ppanggolin_info
doc: "Show information about a pangenome.\n\nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: content
    type:
      - 'null'
      - boolean
    doc: Display detailed information about the pangenome's content
    inputBinding:
      position: 101
      prefix: --content
  - id: metadata
    type:
      - 'null'
      - boolean
    doc: Display a summary of the metadata saved in the pangenome
    inputBinding:
      position: 101
      prefix: --metadata
  - id: pangenome
    type: File
    doc: Path to the pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: parameters
    type:
      - 'null'
      - boolean
    doc: Display the parameters used or computed for each step of pangenome 
      generation
    inputBinding:
      position: 101
      prefix: --parameters
  - id: status
    type:
      - 'null'
      - boolean
    doc: Display information about the statuses of different elements in the 
      pangenome, indicating what has been computed or not
    inputBinding:
      position: 101
      prefix: --status
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
stdout: ppanggolin_info.out
