cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-bin-plusgui
label: relion-bin-plusgui
doc: "RELION (REgularised LIkelihood Optimisation) is a software package for cryo-electron
  microscopy. Note: The provided text contains container runtime error logs rather
  than command-line help documentation.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusgui.out
