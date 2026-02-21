cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-bin-plusmpi-plusgui
label: relion-bin-plusmpi-plusgui
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the tool.
  RELION (REgularised LIkelihood Optimisation) is a software package for cryo-electron
  microscopy.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi-plusgui.out
