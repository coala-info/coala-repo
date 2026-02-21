cwlVersion: v1.2
class: CommandLineTool
baseCommand: clermontyping_makeblastdb
label: clermontyping_makeblastdb
doc: "The provided text does not contain help information or usage instructions for
  clermontyping_makeblastdb. It contains error logs related to a container environment
  (Apptainer/Singularity) failing to extract an image due to lack of disk space.\n
  \nTool homepage: https://github.com/happykhan/ClermonTyping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clermontyping:24.02--py312hdfd78af_1
stdout: clermontyping_makeblastdb.out
