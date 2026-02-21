cwlVersion: v1.2
class: CommandLineTool
baseCommand: dextractor
label: dextractor
doc: "A tool for extracting data from sequencing files (Note: The provided text contains
  container runtime error logs rather than tool help documentation).\n\nTool homepage:
  https://github.com/Perfare/UnityLive2DExtractor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dextractor:1.0p2--hb2ce006_9
stdout: dextractor.out
