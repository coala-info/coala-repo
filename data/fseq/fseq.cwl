cwlVersion: v1.2
class: CommandLineTool
baseCommand: fseq
label: fseq
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log regarding a container build failure
  (no space left on device).\n\nTool homepage: http://fureylab.web.unc.edu/software/fseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fseq:1.84--py35pl5.22.0_0
stdout: fseq.out
