cwlVersion: v1.2
class: CommandLineTool
baseCommand: biosigner
label: biosigner
doc: "A tool for discovery of significant features in omics data (Note: The provided
  help text contained only execution logs and no usage information).\n\nTool homepage:
  https://github.com/bioconductor-source/biosigner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosigner:phenomenal-v2.2.8_cv1.4.26
stdout: biosigner.out
