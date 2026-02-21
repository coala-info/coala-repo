cwlVersion: v1.2
class: CommandLineTool
baseCommand: strudel
label: strudel
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to fetch the image.\n\nTool homepage: https://ics.hutton.ac.uk/strudel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strudel:1.15.08.25--1
stdout: strudel.out
