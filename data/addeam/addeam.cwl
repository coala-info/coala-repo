cwlVersion: v1.2
class: CommandLineTool
baseCommand: addeam
label: addeam
doc: "The provided text does not contain help information or usage instructions for
  the tool 'addeam'. It is a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/LouisPwr/AdDeam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/addeam:1.0.0--py313h1510ab2_0
stdout: addeam.out
