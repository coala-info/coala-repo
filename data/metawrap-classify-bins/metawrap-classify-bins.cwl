cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap-classify-bins
label: metawrap-classify-bins
doc: "A tool for classifying metagenomic bins. (Note: The provided text was an error
  log and did not contain usage information or argument descriptions).\n\nTool homepage:
  https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-classify-bins:1.3.0--hdfd78af_3
stdout: metawrap-classify-bins.out
