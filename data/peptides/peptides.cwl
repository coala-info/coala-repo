cwlVersion: v1.2
class: CommandLineTool
baseCommand: peptides
label: peptides
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help text or argument definitions for the 'peptides' tool.\n\
  \nTool homepage: https://peptides.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peptides:0.5.0--pyh7e72e81_0
stdout: peptides.out
