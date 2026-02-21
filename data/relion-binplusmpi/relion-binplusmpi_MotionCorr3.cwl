cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_motioncorr3
label: relion-binplusmpi_MotionCorr3
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log. No arguments could be parsed from the input.\n
  \nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-binplusmpi:v1.4dfsg-2b2-deb_cv1
stdout: relion-binplusmpi_MotionCorr3.out
