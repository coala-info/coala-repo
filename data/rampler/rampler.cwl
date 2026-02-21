cwlVersion: v1.2
class: CommandLineTool
baseCommand: rampler
label: rampler
doc: "A tool for sampling genomic sequences (Note: The provided text contains error
  logs rather than help documentation, so arguments could not be extracted).\n\nTool
  homepage: https://github.com/rvaser/rampler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rampler:v1.1.0-1-deb_cv1
stdout: rampler.out
