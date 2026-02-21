cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbml2metexplorejsongraph
label: sbml2metexplorejsongraph
doc: "A tool to convert SBML (Systems Biology Markup Language) files into MetExplore
  JSON graph format. Note: The provided text contains container runtime errors and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/bmerlet90/tool-SBML2MetexploreJsonGraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sbml2metexplorejsongraph:phenomenal-v1.2_cv1.1.7
stdout: sbml2metexplorejsongraph.out
