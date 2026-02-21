cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap-kraken
label: metawrap-kraken
doc: "The provided text does not contain help information or usage instructions. It
  contains container runtime error messages regarding a failure to build a SIF image
  due to lack of disk space.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-kraken:1.3.0--hdfd78af_3
stdout: metawrap-kraken.out
