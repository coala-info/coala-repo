cwlVersion: v1.2
class: CommandLineTool
baseCommand: partitionfinder2
label: partitionfinder2
doc: "PartitionFinder2 is a program for selecting best-fit partitioning schemes and
  models of evolution for phylogenetic analyses.\n\nTool homepage: https://github.com/JR-Montes/PartitionFinder2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/partitionfinder2:v2.1.1_cv3
stdout: partitionfinder2.out
