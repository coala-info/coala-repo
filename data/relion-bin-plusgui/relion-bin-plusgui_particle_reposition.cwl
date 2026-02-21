cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_particle_reposition
label: relion-bin-plusgui_particle_reposition
doc: "A tool from the RELION package for repositioning particles. (Note: The provided
  help text contains only container runtime error messages and no usage information.)\n
  \nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusgui_particle_reposition.out
