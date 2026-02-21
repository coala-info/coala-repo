cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirnature
label: mirnature
doc: "A tool for miRNA discovery and analysis (Note: The provided text contains container
  runtime error logs rather than command-line help documentation).\n\nTool homepage:
  https://github.com/Bierinformatik/miRNAture"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirnature:1.1--pl5321hdfd78af_2
stdout: mirnature.out
