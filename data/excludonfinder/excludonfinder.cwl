cwlVersion: v1.2
class: CommandLineTool
baseCommand: excludonfinder
label: excludonfinder
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container environment (Apptainer/Singularity)
  failing to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/Alvarosmb/ExcludonFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/excludonfinder:0.2.0--hdfd78af_0
stdout: excludonfinder.out
