cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxoniumtools
label: taxoniumtools
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a log of a failed container build/fetch process for the taxoniumtools
  image.\n\nTool homepage: https://github.com/theosanderson/taxonium"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxoniumtools:2.1.17--pyhdfd78af_0
stdout: taxoniumtools.out
