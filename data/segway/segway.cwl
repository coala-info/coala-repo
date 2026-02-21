cwlVersion: v1.2
class: CommandLineTool
baseCommand: segway
label: segway
doc: "The provided text does not contain help information for the 'segway' tool; it
  is an error log from a container build process (Apptainer/Singularity) indicating
  a 'no space left on device' failure.\n\nTool homepage: http://segway.hoffmanlab.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1
stdout: segway.out
