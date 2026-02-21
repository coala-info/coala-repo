cwlVersion: v1.2
class: CommandLineTool
baseCommand: propy3
label: propy3
doc: "The provided text does not contain help information for the tool 'propy3'; it
  is an error log from a Singularity/Apptainer container build process.\n\nTool homepage:
  https://github.com/MartinThoma/propy3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/propy3:1.1.1--pyhdfd78af_0
stdout: propy3.out
