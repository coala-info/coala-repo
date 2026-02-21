cwlVersion: v1.2
class: CommandLineTool
baseCommand: occultercut
label: occultercut
doc: "OcculterCut is a software tool designed to identify AT-poor regions (isochores)
  in fungal genomes, which are often associated with specific genomic features like
  effector genes.\n\nTool homepage: https://sourceforge.net/projects/occultercut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/occultercut:1.1--h503566f_1
stdout: occultercut.out
