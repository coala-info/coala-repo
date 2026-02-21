cwlVersion: v1.2
class: CommandLineTool
baseCommand: tetranscripts
label: tetranscripts
doc: "TEtranscripts is a software package for including transposable elements (TEs)
  in differential expression analysis of RNA-seq data.\n\nTool homepage: http://hammelllab.labsites.cshl.edu/software#TEToolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tetranscripts:2.2.3--pyh7cba7a3_0
stdout: tetranscripts.out
