cwlVersion: v1.2
class: CommandLineTool
baseCommand: recycler_bwa
label: recycler_bwa
doc: "The provided text does not contain help information for the tool; it appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/Shamir-Lab/Recycler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
stdout: recycler_bwa.out
