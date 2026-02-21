cwlVersion: v1.2
class: CommandLineTool
baseCommand: oatk_path_to_fasta
label: oatk_path_to_fasta
doc: "The provided text does not contain help information for the tool; it contains
  system error logs related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/c-zhou/oatk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oatk:1.0
stdout: oatk_path_to_fasta.out
