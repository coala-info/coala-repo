cwlVersion: v1.2
class: CommandLineTool
baseCommand: me-pcr
label: me-pcr
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or run a container due to
  insufficient disk space.\n\nTool homepage: https://web.archive.org/web/20100708193215/http://genome.chop.edu/mePCR/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/me-pcr:1.0.6--h503566f_1
stdout: me-pcr.out
