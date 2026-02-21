cwlVersion: v1.2
class: CommandLineTool
baseCommand: uvaia
label: uvaia
doc: "The provided text is a container engine log (Apptainer/Singularity) and does
  not contain help documentation or argument definitions for the tool 'uvaia'.\n\n
  Tool homepage: https://github.com/quadram-institute-bioscience/uvaia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uvaia:2.0.1--heee599d_3
stdout: uvaia.out
