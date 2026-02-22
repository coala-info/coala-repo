cwlVersion: v1.2
class: CommandLineTool
baseCommand: bowtie
label: bioperl-run_Bowtie
doc: "The provided text does not contain help information for the tool, but appears
  to be error logs related to a container execution failure (no space left on device).\n\
  \nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_Bowtie.out
