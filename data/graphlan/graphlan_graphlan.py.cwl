cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphlan_graphlan.py
label: graphlan_graphlan.py
doc: "GraPhlAn is a software tool for producing high-quality circular representations
  of taxonomic and phylogenetic trees. (Note: The provided help text contained only
  system error messages regarding container execution and did not list command-line
  arguments.)\n\nTool homepage: https://bitbucket.org/nsegata/graphlan/wiki/Home"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/graphlan:v1.1.3-1-deb_cv1
stdout: graphlan_graphlan.py.out
