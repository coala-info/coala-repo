cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqwin
label: seqwin
doc: "The provided text does not contain help information for the tool 'seqwin'. It
  is a log of a failed container build process due to insufficient disk space ('no
  space left on device').\n\nTool homepage: https://github.com/treangenlab/seqwin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqwin:0.2.1--pyhdfd78af_0
stdout: seqwin.out
