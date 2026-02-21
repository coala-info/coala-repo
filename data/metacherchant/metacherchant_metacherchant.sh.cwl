cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacherchant.sh
label: metacherchant_metacherchant.sh
doc: "Metacherchant is a tool for metagenomic analysis. (Note: The provided help text
  contains only environment information and a fatal error regarding disk space; no
  usage instructions or arguments were found in the input.)\n\nTool homepage: https://github.com/ctlab/metacherchant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacherchant:0.1.0--1
stdout: metacherchant_metacherchant.sh.out
