cwlVersion: v1.2
class: CommandLineTool
baseCommand: partition
label: rnastructure_partition
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error logs. No arguments could be extracted from the input.\n\n
  Tool homepage: http://rna.urmc.rochester.edu/RNAstructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
stdout: rnastructure_partition.out
