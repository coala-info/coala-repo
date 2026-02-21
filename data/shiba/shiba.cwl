cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiba
label: shiba
doc: "Small RNA-seq High-throughput Interactive Browser and Analyzer (Note: The provided
  text was an error log and did not contain CLI help information).\n\nTool homepage:
  https://github.com/Sika-Zheng-Lab/Shiba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiba:0.8.1--py312hdfd78af_0
stdout: shiba.out
