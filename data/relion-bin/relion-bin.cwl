cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-bin
label: relion-bin
doc: "Relion (REgularised LIkelihood Optimisation) is a software package for Cryo-electron
  microscopy. Note: The provided text contains container build logs and error messages
  rather than command-line help documentation.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin:v1.4dfsg-4-deb_cv1
stdout: relion-bin.out
