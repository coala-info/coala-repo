cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_postprocess
label: relion-bin-plusmpi-plusgui_relion_postprocess
doc: "A tool for post-processing of 3D reconstructions in RELION.\n\nTool homepage:
  https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi-plusgui_relion_postprocess.out
