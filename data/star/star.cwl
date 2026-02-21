cwlVersion: v1.2
class: CommandLineTool
baseCommand: star
label: star
doc: "The provided text does not contain help information or usage instructions for
  the STAR tool; it is a log of a failed container build process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/alexdobin/STAR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/star:2.7.0b--0
stdout: star.out
