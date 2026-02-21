cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - carpedeam
  - ancient_assemble
label: carpedeam_ancient_assemble
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure.\n\nTool homepage: https://github.com/LouisPwr/CarpeDeam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carpedeam:1.0.1--hd6d6fdc_0
stdout: carpedeam_ancient_assemble.out
