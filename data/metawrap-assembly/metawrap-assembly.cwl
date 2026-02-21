cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap-assembly
label: metawrap-assembly
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container image building
  (no space left on device).\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-assembly:1.3.0--hdfd78af_3
stdout: metawrap-assembly.out
