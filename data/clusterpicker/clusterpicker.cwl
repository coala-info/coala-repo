cwlVersion: v1.2
class: CommandLineTool
baseCommand: clusterpicker
label: clusterpicker
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to insufficient disk space.\n\nTool homepage: http://hiv.bio.ed.ac.uk/software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterpicker:1.2.5--hdfd78af_1
stdout: clusterpicker.out
