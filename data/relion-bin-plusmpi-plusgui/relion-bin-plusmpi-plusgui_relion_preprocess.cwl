cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_preprocess
label: relion-bin-plusmpi-plusgui_relion_preprocess
doc: "A tool for preprocessing images in the RELION cryo-electron microscopy software
  package. Note: The provided input text contains container runtime errors and does
  not include the actual help documentation for the tool.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi-plusgui_relion_preprocess.out
