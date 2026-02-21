cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphlan
label: graphlan
doc: "GraPhlAn is a software tool for producing high-quality circular representations
  of taxonomic and phylogenetic trees. (Note: The provided text contains system error
  messages regarding container execution and does not list command-line arguments.)\n
  \nTool homepage: https://bitbucket.org/nsegata/graphlan/wiki/Home"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/graphlan:v1.1.3-1-deb_cv1
stdout: graphlan.out
