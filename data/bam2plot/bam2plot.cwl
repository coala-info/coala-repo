cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2plot
label: bam2plot
doc: "The provided text does not contain help information for bam2plot; it contains
  system log messages and a fatal error regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/willros/bam2plot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bam2plot:0.3.7--pyhdfd78af_0
stdout: bam2plot.out
