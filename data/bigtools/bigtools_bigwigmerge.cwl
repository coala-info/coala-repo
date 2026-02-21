cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigwigmerge
label: bigtools_bigwigmerge
doc: "The provided text does not contain help information for bigwigmerge; it contains
  container runtime error logs indicating a 'no space left on device' failure during
  image extraction.\n\nTool homepage: https://github.com/jackh726/bigtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
stdout: bigtools_bigwigmerge.out
