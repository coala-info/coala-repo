cwlVersion: v1.2
class: CommandLineTool
baseCommand: meryl
label: canu_meryl
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract a container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/marbl/canu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canu:2.3--h3fb4750_2
stdout: canu_meryl.out
