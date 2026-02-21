cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-binplusmpi_Blush
label: relion-binplusmpi_Blush
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime logs and a fatal error message indicating a failure to fetch
  or build the image.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-binplusmpi:v1.4dfsg-2b2-deb_cv1
stdout: relion-binplusmpi_Blush.out
