cwlVersion: v1.2
class: CommandLineTool
baseCommand: lastz
label: lastz
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains container runtime error messages related to Apptainer/Singularity.\n
  \nTool homepage: http://www.bx.psu.edu/~rsharris/lastz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lastz:1.04.52--h7b50bb2_1
stdout: lastz.out
