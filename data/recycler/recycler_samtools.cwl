cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: recycler_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/Shamir-Lab/Recycler"
inputs:
  - id: command
    type: string
    doc: samtools command
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
stdout: recycler_samtools.out
