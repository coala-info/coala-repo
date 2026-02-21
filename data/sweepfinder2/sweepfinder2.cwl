cwlVersion: v1.2
class: CommandLineTool
baseCommand: SweepFinder2
label: sweepfinder2
doc: "The provided text does not contain help information for sweepfinder2; it is
  a log of a failed container build process. No arguments or tool descriptions could
  be extracted from the input.\n\nTool homepage: https://github.com/mdegiorgio/SweepFinder2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sweepfinder2:1.0--h7b50bb2_6
stdout: sweepfinder2.out
