cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap-annotate-bins
label: metawrap-annotate-bins
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding a container
  build failure (no space left on device).\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-annotate-bins:1.3.0--hdfd78af_3
stdout: metawrap-annotate-bins.out
