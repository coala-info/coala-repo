cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaborn
label: seaborn
doc: "The provided text is a system error log from a container engine (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions for the tool 'seaborn'.\n
  \nTool homepage: https://github.com/mwaskom/seaborn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seaborn:0.13.2
stdout: seaborn.out
