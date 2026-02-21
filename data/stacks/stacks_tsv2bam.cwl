cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv2bam
label: stacks_tsv2bam
doc: "The provided text does not contain help information for stacks_tsv2bam; it contains
  container runtime error logs. No arguments could be extracted.\n\nTool homepage:
  https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_tsv2bam.out
