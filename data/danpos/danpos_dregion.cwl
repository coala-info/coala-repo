cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - danpos.py
  - dregion
label: danpos_dregion
doc: "The provided text contains system logs and error messages related to a container
  build failure and does not contain the help text for the tool. Based on the tool
  name hint, this is part of the DANPOS (Dynamic Analysis of Nucleosome Positioning
  and Occupancy by Sequencing) suite, specifically the 'dregion' subcommand for detecting
  differential regions.\n\nTool homepage: https://sites.google.com/site/danposdoc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/danpos:v2.2.2_cv3
stdout: danpos_dregion.out
