cwlVersion: v1.2
class: CommandLineTool
baseCommand: align_it
label: align_it
doc: "No description available: The provided text is an error log, not help text.\n
  \nTool homepage: http://silicos-it.be.s3-website-eu-west-1.amazonaws.com/software/align-it/1.0.4/align-it.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alignlib-lite:0.3--py312h9c9b0c2_9
stdout: align_it.out
