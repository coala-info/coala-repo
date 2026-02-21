cwlVersion: v1.2
class: CommandLineTool
baseCommand: minys
label: minys
doc: "MinYS (Mine Your Symbiont) is a tool for the assembly of endosymbiont genomes
  from metagenomic data. (Note: The provided text is a container runtime error log
  and does not contain help documentation or argument definitions.)\n\nTool homepage:
  https://github.com/cguyomar/MinYS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minys:1.1--h9948957_6
stdout: minys.out
