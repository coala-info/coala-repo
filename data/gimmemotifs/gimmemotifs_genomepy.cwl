cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimmemotifs
  - genomepy
label: gimmemotifs_genomepy
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs:0.18.1--h9ee0642_0
stdout: gimmemotifs_genomepy.out
