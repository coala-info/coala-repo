cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioconda-utils
label: bioconda-utils
doc: "Utilities for building, linting, and managing Bioconda recipes. (Note: The provided
  text contained system error logs rather than help documentation, so no arguments
  could be parsed.)\n\nTool homepage: http://bioconda.github.io/build-system.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils.out
