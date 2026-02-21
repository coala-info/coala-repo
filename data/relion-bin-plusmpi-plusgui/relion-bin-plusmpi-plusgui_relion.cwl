cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion
label: relion-bin-plusmpi-plusgui_relion
doc: "RELION (REgularised LIkelihood Optimisation) is a software package for Cryo-Electron
  Microscopy (Cryo-EM). Note: The provided text appears to be a container engine error
  log rather than tool help text.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi-plusgui_relion.out
