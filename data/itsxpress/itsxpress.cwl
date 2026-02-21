cwlVersion: v1.2
class: CommandLineTool
baseCommand: itsxpress
label: itsxpress
doc: "The provided text is an error message related to a container runtime (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool 'itsxpress'.\n
  \nTool homepage: http://github.com/usda-ars-gbru/itsxpress"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itsxpress:2.1.4--pyhdfd78af_0
stdout: itsxpress.out
