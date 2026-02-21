cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mameshiba
  - shiba2sashimi
label: mameshiba_shiba2sashimi
doc: "The provided text does not contain help information for the tool, but appears
  to be an error log from a container runtime (Apptainer/Singularity) attempting to
  pull the mameshiba image.\n\nTool homepage: https://github.com/Sika-Zheng-Lab/Shiba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mameshiba:0.8.1--hdfd78af_0
stdout: mameshiba_shiba2sashimi.out
