cwlVersion: v1.2
class: CommandLineTool
baseCommand: ete2
label: ete2
doc: "ETE (Environment for Tree Exploration) is a Python framework for the analysis
  and visualization of phylogenetic trees.\n\nTool homepage: https://github.com/elaelheni/INF2050-ETE2020"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ete2:2.3.10--py27_1
stdout: ete2.out
