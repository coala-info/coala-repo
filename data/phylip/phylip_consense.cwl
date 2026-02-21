cwlVersion: v1.2
class: CommandLineTool
baseCommand: consense
label: phylip_consense
doc: "The provided text does not contain help information for the tool. It appears
  to be a series of system logs and a fatal error message related to a container build
  process (Singularity/Apptainer).\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_consense.out
