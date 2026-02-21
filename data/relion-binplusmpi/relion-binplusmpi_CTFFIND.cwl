cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-binplusmpi_CTFFIND
label: relion-binplusmpi_CTFFIND
doc: "CTFFIND tool from the RELION package. (Note: The provided help text contains
  container runtime error logs rather than tool usage information, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-binplusmpi:v1.4dfsg-2b2-deb_cv1
stdout: relion-binplusmpi_CTFFIND.out
