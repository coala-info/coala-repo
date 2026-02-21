cwlVersion: v1.2
class: CommandLineTool
baseCommand: optilcms
label: optilcms
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build the container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/xia-lab/OptiLCMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optilcms:1.1.0--r43hdfd78af_0
stdout: optilcms.out
