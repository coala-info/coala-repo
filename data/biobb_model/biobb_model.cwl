cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_model
label: biobb_model
doc: "The provided text is a system error log (Singularity/Apptainer build failure)
  and does not contain help documentation or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/bioexcel/biobb_model"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_model:5.2.0--pyhdfd78af_0
stdout: biobb_model.out
