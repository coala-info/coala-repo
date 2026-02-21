cwlVersion: v1.2
class: CommandLineTool
baseCommand: hr2
label: hr2
doc: "The provided text does not contain help information for the tool 'hr2'. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build a SIF image due to insufficient disk space.\n\nTool homepage: http://fiehnlab.ucdavis.edu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hr2:1.04--h9948957_6
stdout: hr2.out
