cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap-mg
label: metawrap-mg
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log indicating a failure to build or run a container due
  to insufficient disk space.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-mg:1.3.0--hdfd78af_3
stdout: metawrap-mg.out
