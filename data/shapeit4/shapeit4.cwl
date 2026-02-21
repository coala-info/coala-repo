cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit4
label: shapeit4
doc: "The provided text is an error log from a container build process (Singularity/Apptainer)
  and does not contain the help text or argument definitions for the shapeit4 tool.\n
  \nTool homepage: https://odelaneau.github.io/shapeit4/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit4:4.2.2--h6959450_5
stdout: shapeit4.out
