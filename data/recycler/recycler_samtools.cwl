cwlVersion: v1.2
class: CommandLineTool
baseCommand: recycler_samtools
label: recycler_samtools
doc: "No description available: The provided text contains container runtime error
  messages rather than tool help text.\n\nTool homepage: https://github.com/Shamir-Lab/Recycler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
stdout: recycler_samtools.out
