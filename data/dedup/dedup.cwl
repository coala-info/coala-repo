cwlVersion: v1.2
class: CommandLineTool
baseCommand: dedup
label: dedup
doc: "The provided text does not contain help information or usage instructions; it
  is an error log indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/apeltzer/dedup"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dedup:0.12.9--hdfd78af_0
stdout: dedup.out
