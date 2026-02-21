cwlVersion: v1.2
class: CommandLineTool
baseCommand: bakta
label: bakta
doc: "Bakta is a tool for the rapid & standardized annotation of bacterial genomes
  and plasmids.\n\nTool homepage: https://github.com/oschwengers/bakta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakta:1.12.0--pyhdfd78af_0
stdout: bakta.out
