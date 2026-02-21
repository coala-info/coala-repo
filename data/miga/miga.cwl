cwlVersion: v1.2
class: CommandLineTool
baseCommand: miga
label: miga
doc: "The Microbial Genome Atlas (MiGA) is a data management and processing system
  for microbial genomes and metagenomes.\n\nTool homepage: https://github.com/caioss/miga"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miga:1.0.0--py310h87f3376_0
stdout: miga.out
