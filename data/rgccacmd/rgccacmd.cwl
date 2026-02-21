cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgccacmd
label: rgccacmd
doc: "The provided text does not contain help information or usage instructions for
  rgccacmd. It appears to be a log of a failed container build or image fetch process.\n
  \nTool homepage: https://CRAN.R-project.org/package=RGCCA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgccacmd:3.0.3--r44hdfd78af_2
stdout: rgccacmd.out
