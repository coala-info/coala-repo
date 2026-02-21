cwlVersion: v1.2
class: CommandLineTool
baseCommand: immuneml
label: immuneml
doc: "The provided text is a container runtime error log (Singularity/Apptainer) and
  does not contain help documentation or argument definitions for the immuneml tool.\n
  \nTool homepage: https://github.com/uio-bmi/immuneML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/immuneml:3.0.17--pyhdfd78af_0
stdout: immuneml.out
