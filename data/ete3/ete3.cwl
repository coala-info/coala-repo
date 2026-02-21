cwlVersion: v1.2
class: CommandLineTool
baseCommand: ete3
label: ete3
doc: "The ETE Toolkit (Environment for Tree Exploration) is a Python framework for
  the analysis and visualization of phylogenetic trees.\n\nTool homepage: http://etetoolkit.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ete3:3.1.2
stdout: ete3.out
