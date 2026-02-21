cwlVersion: v1.2
class: CommandLineTool
baseCommand: pargenes
label: pargenes
doc: "The provided text does not contain help information for the tool 'pargenes'.
  It appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  that the executable was not found.\n\nTool homepage: https://github.com/BenoitMorel/ParGenes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pargenes:1.2.0--py37hf7b2935_0
stdout: pargenes.out
