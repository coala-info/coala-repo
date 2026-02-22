cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyutility
label: phyutility
doc: "A command-line program for phylogenetic tree and alignment manipulation.\n\n\
  Tool homepage: https://github.com/blackrim/phyutility"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/phyutility:v2.7.3-1-deb_cv1
stdout: phyutility.out
