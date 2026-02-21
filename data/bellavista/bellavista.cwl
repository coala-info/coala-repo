cwlVersion: v1.2
class: CommandLineTool
baseCommand: bellavista
label: bellavista
doc: "The provided text does not contain help documentation or usage instructions
  for the tool 'bellavista'. It contains log messages and a fatal error related to
  a container build process (Apptainer/Singularity) failing due to insufficient disk
  space.\n\nTool homepage: https://github.com/pkosurilab/BellaVista"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bellavista:0.0.2--pyhdfd78af_0
stdout: bellavista.out
