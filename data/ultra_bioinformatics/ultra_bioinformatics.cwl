cwlVersion: v1.2
class: CommandLineTool
baseCommand: ultra
label: ultra_bioinformatics
doc: "The provided text is a system error log from a container build process (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions for the tool 'ultra'.\n
  \nTool homepage: https://github.com/ksahlin/uLTRA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ultra:1.2.1--h9948957_0
stdout: ultra_bioinformatics.out
