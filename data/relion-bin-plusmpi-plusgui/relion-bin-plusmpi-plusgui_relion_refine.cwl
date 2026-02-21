cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_refine
label: relion-bin-plusmpi-plusgui_relion_refine
doc: "A tool for 3D refinement in the RELION (REgularised LIkelihood OptimizatioN)
  package. Note: The provided input text contains system logs and error messages rather
  than the tool's help documentation, so no arguments could be extracted.\n\nTool
  homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi-plusgui_relion_refine.out
