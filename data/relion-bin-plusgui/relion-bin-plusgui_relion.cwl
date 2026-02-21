cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion
label: relion-bin-plusgui_relion
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system log or error message from a container runtime (Apptainer/Singularity)
  failing to fetch or build a container image.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusgui_relion.out
