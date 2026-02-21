cwlVersion: v1.2
class: CommandLineTool
baseCommand: ruby-dna-tools
label: ruby-dna-tools
doc: "The provided text does not contain help information for the tool; it contains
  container runtime logs and a fatal error message regarding image retrieval.\n\n
  Tool homepage: https://github.com/Carldeboer/Ruby-DNA-Tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ruby-dna-tools:1.0--1
stdout: ruby-dna-tools.out
