cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseqqc
label: htseqqc
doc: "Quality control for high-throughput sequencing data (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://reneshbedre.github.io/blog/htseqqc.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseqqc:v1.0--pyh5bfb8f1_0
stdout: htseqqc.out
