cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigwigaverageoverbed
label: bigtools_bigwigaverageoverbed
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a failure to build or extract a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/jackh726/bigtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
stdout: bigtools_bigwigaverageoverbed.out
